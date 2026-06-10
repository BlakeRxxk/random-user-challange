//
//  RandomUserRepository.swift
//  RandomUserDomain
//

import Foundation

public protocol RandomUserRepository: Sendable {
    func fetchUsers(page: Int, results: Int) async throws -> [User]
}
