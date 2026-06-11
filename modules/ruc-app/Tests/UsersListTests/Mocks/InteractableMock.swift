//
//  InteractableMock.swift
//  UsersListTests
//

import RUCCore

final class InteractableMock: @unchecked Interactable {
    var isActive = false
    var lifecycleStream: AsyncStream<LifecycleState> = AsyncStream { _ in }

    func activate() {
        isActive = true
    }

    func deactivate() {
        isActive = false
    }
}
