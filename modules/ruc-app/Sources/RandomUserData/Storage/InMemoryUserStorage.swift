//
//  InMemoryUserStorage.swift
//  RandomUserData
//

import Foundation
import RandomUserDomain

public actor InMemoryUserStorage: RandomUserStorage {

    // MARK: Lifecycle

    public init() { }

    // MARK: Public

    public func save(_ users: [User]) {
        self.users = users
    }

    public func loadUsers() -> [User] {
        users
    }

    public func search(query: String) -> [User] {
        guard !query.isEmpty else {
            return users
        }

        return users.filter {
            $0.name.first.localizedCaseInsensitiveContains(query)
                || $0.name.last.localizedCaseInsensitiveContains(query)
                || $0.email.localizedCaseInsensitiveContains(query)
        }
    }

    public func delete(userId: String) async -> [User] {
        users.removeAll { $0.id.uuidString == userId }
        return users
    }

    public func get(userId: String) async throws -> User? {
        users.first { $0.id.uuidString == userId }
    }

    // MARK: Private

    private var users = [User]()

}
