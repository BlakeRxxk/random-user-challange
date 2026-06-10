//
//  HTTPClientProtocol.swift
//  RUCCore
//

import Foundation

public protocol HTTPClientProtocol: Sendable {

    init(configuration: URLSessionConfiguration, decoder: JSONDecoder, logger: Logger)

    func request<Response: Decodable>(
        _ method: HTTPMethod,
        _ route: Routable,
        parameters: [String: Any]?,
    ) async throws -> Response

}
