//
//  RandomUserAPIClient.swift
//  RandomUserData
//

import Foundation
import RandomUserDomain
import RUCNetwork

// MARK: - RandomUserAPIClient

public final class RandomUserAPIClient {

    // MARK: Lifecycle

    public init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }

    // MARK: Private

    private let httpClient: HTTPClientProtocol

}

// MARK: RandomUserRepository

extension RandomUserAPIClient: RandomUserRepository {
    public func fetchUsers(page: Int, results: Int) async throws -> [User] {
        var parameters: [String: Any] = [
            "page": page,
            "results": results,
            "seed": "abc",
        ]

        let response: RandomUserResponseDTO = try await httpClient.request(.get, RandomUserAPI.userList, parameters: parameters)

        return UserMapper.map(response)
    }
}
