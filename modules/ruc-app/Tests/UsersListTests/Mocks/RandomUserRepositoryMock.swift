//
//  RandomUserRepositoryMock.swift
//  UsersListTests
//

import RandomUserDomain
import RUCCore

// swiftlint:disable:next no_unchecked_sendable
final class RandomUserRepositoryMock: RandomUserRepository, @unchecked Sendable {

    // fetchUsers
    var fetchUsersResult = Result<[User], Error>.success([])
    var fetchUsersCallCount = 0
    var fetchUsersReceivedPages = [Int]()
    var onFetchUsers: (() -> Void)?

    // searchUsers
    var searchUsersResult = Result<[User], Error>.success([])
    var searchUsersCallCount = 0
    var searchUsersReceivedQuery: String?

    // deleteUser
    var deleteUserResult = [User]()
    var deleteUserCallCount = 0
    var deleteUserReceivedID: String?

    /// loadUsers
    var loadUsersResult = Result<[User], Error>.success([])

    func fetchUsers(page: Int, results _: Int) async throws -> [User] {
        onFetchUsers?()
        fetchUsersCallCount += 1
        fetchUsersReceivedPages.append(page)
        return try fetchUsersResult.get()
    }

    func searchUsers(query: String) async throws -> [User] {
        searchUsersCallCount += 1
        searchUsersReceivedQuery = query
        return try searchUsersResult.get()
    }

    func deleteUser(with id: String) async -> [User] {
        deleteUserCallCount += 1
        deleteUserReceivedID = id
        return deleteUserResult
    }

    func loadUsers() async throws -> [User] {
        try loadUsersResult.get()
    }

    /// fetchUser
    func fetchUser(with _: String) async throws -> User? {
        nil
    }

}
