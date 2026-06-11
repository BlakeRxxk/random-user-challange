//
//  InMemoryUserStorage.swift
//  RandomUserData
//

import Foundation
import RandomUserDomain

public actor InMemoryUserStorage: RandomUserStorage {

    private var users: [User] = []

    public init() {}

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
}
