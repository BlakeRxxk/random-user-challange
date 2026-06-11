//
//  RandomUserAPIClient.swift
//  RandomUserData
//

import Foundation
import RandomUserDomain
import RUCNetwork

// MARK: - RandomUserAPIClient

public final class RandomUserAPIClient: Sendable {

    // MARK: Lifecycle

    public init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }

    // MARK: Private

    private let httpClient: HTTPClientProtocol

}

// MARK: RandomUserRepository

extension RandomUserAPIClient {
    public func fetchUsers(page: Int, results: Int) async throws -> [UserDTO] {
        var parameters: [String: Any] = [
            "page": page,
            "results": results,
            "seed": "abc",
            "nat": "de",
        ]

        let response: RandomUserResponseDTO = try await httpClient.request(.get, RandomUserAPI.userList, parameters: parameters)

        return response.results
    }
}
