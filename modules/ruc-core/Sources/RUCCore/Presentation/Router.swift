//
//  Router.swift
//  RUCCore
//

import Foundation

// MARK: - LifecycleState

/// Represents the activation state of an interactor.

public enum LifecycleState: Sendable {
    case active
    case inactive
}

// MARK: - Routing

/// Protocol a router uses to communicate attach/detach actions to its interactor.
public protocol Routing: AnyObject {
    /// The interactor owned by this router.
    var interactable: any Interactable { get }

    /// All currently attached child routers.
    var children: [any Routing] { get }

    /// Loads the router (called once by the parent before first attach).
    func load()

    /// Attaches a child router, activating its interactor.
    @MainActor
    func attach(child: any Routing)

    /// Detaches a child router, deactivating its interactor.
    @MainActor
    func detach(child: any Routing)
}

// MARK: - Router

open class Router<InteractorType>: Routing {

    // MARK: Lifecycle

    public init(interactor: InteractorType) {
        self.interactor = interactor
        guard let interactable = interactor as? Interactable else {
            fatalError("\(interactor) should conform to \(Interactable.self)")
        }
        self.interactable = interactable
    }

    // MARK: Open

    open func didLoad() { }

    // MARK: Public

    public let interactor: InteractorType
    public let interactable: Interactable

    public private(set) var children = [any Routing]()

    public final func load() {
        interactable.activate()
        didLoad()
    }

    public final func attach(child: any Routing) {
        assert(
            !children.contains(where: { $0 === child }),
            "Child router \(child) is already attached to \(self)",
        )

        children.append(child)
        child.load()
    }

    public final func detach(child: any Routing) {
        guard let index = children.firstIndex(where: { $0 === child }) else {
            assertionFailure("Attempted to detach router \(child) that is not a child of \(self)")

            return
        }

        child.interactable.deactivate()
        children.remove(at: index)
    }

    @discardableResult
    public func performOnActivate(_ operation: @escaping @Sendable () async -> Void) -> Task<Void, Never> {
        let interactor = interactable

        return Task { [weak interactor] in
            guard let interactor else { return }

            for await state in interactor.lifecycleStream {
                if state == .active { break }
            }

            await withTaskCancellationHandler(operation: {
                await operation()
            }, onCancel: {
                // do nothing
            })
        }
    }

}
