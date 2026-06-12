//
//  InteractableMock.swift
//  UsersListTests
//

import RUCCore
// swiftlint:disable:next no_unchecked_sendable
final class InteractableMock: Interactable, @unchecked Sendable {
    var isActive = false
    var lifecycleStream: AsyncStream<LifecycleState> = AsyncStream { _ in }

    func activate() {
        isActive = true
    }

    func deactivate() {
        isActive = false
    }
}
