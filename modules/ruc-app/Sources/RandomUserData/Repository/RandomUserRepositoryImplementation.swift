//
//  RandomUserRepositoryImplementation.swift
//  RandomUserData
//

import Foundation
import RandomUserDomain

// MARK: - RandomUserRepositoryImplementation

public final class RandomUserRepositoryImplementation {

    // MARK: Lifecycle

    public init(networkClient: RandomUserAPIClient, storage: RandomUserStorage) {
        self.networkClient = networkClient
        self.storage = storage
    }

    // MARK: Private

    private let networkClient: RandomUserAPIClient
    private let storage: RandomUserStorage

}

// MARK: RandomUserRepository

extension RandomUserRepositoryImplementation: RandomUserRepository {
    public func fetchUsers(page: Int, results: Int) async throws -> [User] {
        let usersDTO = try await networkClient.fetchUsers(page: page, results: results)
        let users = usersDTO.compactMap(UserMapper.map)
        if page == 1 {
            await storage.clear()
        }
        try await storage.save(users)
        return try await storage.loadUsers()
    }

    public func searchUsers(query: String) async throws -> [User] {
        try await storage.search(query: query)
    }

    public func deleteUser(with id: String) async -> [User] {
        await storage.delete(userId: id)
    }

    public func fetchUser(with id: String) async throws -> User? {
        try await storage.get(userId: id)
    }
}
