//
//  RandomUserRepository.swift
//  RandomUserDomain
//

import Foundation

public protocol RandomUserRepository: AnyObject, Sendable {
    func fetchUsers(page: Int, results: Int) async throws -> [User]
    func searchUsers(query: String) async throws -> [User]
    func deleteUser(with id: String) async throws -> [User]
}
