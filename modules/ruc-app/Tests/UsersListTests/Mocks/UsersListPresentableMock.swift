//
//  UsersListPresentableMock.swift
//  UsersListTests
//

import RandomUserDomain
import RUCCore
import UsersList

@MainActor
final class UsersListPresentableMock: UsersListPresentable {
    var listener: UsersListPresentableListener?

    private(set) var displayedUsers = [[UserCellModel]]()
    private(set) var displayErrorCallCount = 0

    /// Convenience
    var lastDisplayedUsers: [UserCellModel]? {
        displayedUsers.last
    }

    var displayCallCount: Int {
        displayedUsers.count
    }

    func display(users: [UserCellModel]) {
        displayedUsers.append(users)
    }

    func displayError() {
        displayErrorCallCount += 1
    }
}
