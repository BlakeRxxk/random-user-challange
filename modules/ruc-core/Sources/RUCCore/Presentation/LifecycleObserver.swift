//
//  LifecycleObserver.swift
//  RUCCore
//

import Foundation

// MARK: - LifecycleObservable Helper

/// Utility to observe interactor lifecycle outside of a router (e.g. in tests or helper objects).
///
/// Replaces:
///     interactor.isActiveStream
///         .filter { $0 }
///         .take(1)
///         .subscribe(...)
///
/// With:
///     await LifecycleObserver.waitForActive(interactor)
public enum LifecycleObserver {
    public static func waitForActive(_ scope: any InteractorScope) async {
        if scope.isActive { return }
        for await state in scope.lifecycleStream {
            if state == .active { return }
        }
    }

    public static func waitForInactive(_ scope: any InteractorScope) async {
        if !scope.isActive { return }
        for await state in scope.lifecycleStream {
            if state == .inactive { return }
        }
    }

    /// Observes lifecycle state changes, calling the provided closure on each change.
    /// Runs until the task is cancelled.
    public static func observe(
        _ scope: any InteractorScope,
        handler: @escaping @Sendable (LifecycleState) async -> Void,
    ) -> Task<Void, Never> {
        Task {
            for await state in scope.lifecycleStream {
                await handler(state)
                if Task.isCancelled { break }
            }
        }
    }
}
