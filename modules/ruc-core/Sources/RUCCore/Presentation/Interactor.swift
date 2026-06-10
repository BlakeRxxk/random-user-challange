//
//  Interactor.swift
//  RUCCore
//

import Foundation

// MARK: - InteractorScope

public protocol InteractorScope: AnyObject, Sendable {
    var lifecycleStream: AsyncStream<LifecycleState> { get }

    /// Whether this interactor is currently active.
    var isActive: Bool { get }
}

// MARK: - Interactable

public protocol Interactable: InteractorScope {
    func activate()
    func deactivate()
}

// MARK: - Interactor
// swiftlint:disable:next no_unchecked_sendable
open class Interactor: Interactable, @unchecked Sendable {

    // MARK: Lifecycle

    public init() { }

    deinit {
        withLock { $0.continuations.values.map { $0 } }.forEach { $0.finish() }
    }

    // MARK: Open

    open func didBecomeActive() { }
    open func willResignActive() { }

    // MARK: Public

    public var lifecycleStream: AsyncStream<LifecycleState> {
        AsyncStream { [weak self] continuation in
            guard let self else {
                continuation.finish()
                return
            }
            let id = UUID()
            let current = withLock {
                $0.continuations[id] = continuation
                return $0.lifecycleState
            }
            continuation.yield(current)
            continuation.onTermination = { [weak self] _ in
                self?.withLock { $0.continuations.removeValue(forKey: id) }
            }
        }
    }

    public var isActive: Bool {
        withLock { $0.isActive }
    }

    public func activate() {
        let shouldActivate = withLock {
            guard !$0.isActive else { return false }
            $0.isActive = true
            return true
        }
        guard shouldActivate else { return }
        emit(state: .active)
        didBecomeActive()
    }

    public func deactivate() {
        let shouldDeactivate = withLock {
            guard $0.isActive else { return false }
            $0.isActive = false
            return true
        }
        guard shouldDeactivate else { return }
        willResignActive()
        emit(state: .inactive)
    }

    // MARK: Private

    private struct State {
        var isActive = false
        var lifecycleState = LifecycleState.inactive
        var continuations = [UUID: AsyncStream<LifecycleState>.Continuation]()
    }

    private let lock = NSLock()
    private var state = State()

    @discardableResult
    private func withLock<R>(_ body: (inout State) -> R) -> R {
        lock.withLock { body(&state) }
    }

    private func emit(state: LifecycleState) {
        let continuations = withLock {
            $0.lifecycleState = state
            return $0.continuations.values.map { $0 }
        }
        for continuation in continuations { continuation.yield(state) }
    }

}
