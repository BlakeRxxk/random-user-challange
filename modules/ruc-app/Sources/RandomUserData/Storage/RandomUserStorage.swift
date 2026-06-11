//
//  RandomUserStorage.swift
//  RandomUserData
//

import Foundation
import RandomUserDomain

public protocol RandomUserStorage: Sendable {
    func save(_ users: [User]) async throws
    func loadUsers() async throws -> [User]
    func search(query: String) async throws -> [User]
}
