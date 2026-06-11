//
//  HTTPClient.swift
//  RUCCore
//

import Foundation
import OSLog

// MARK: - HTTPClient

public final class HTTPClient: HTTPClientProtocol {

    // MARK: Lifecycle

    public required init(configuration: URLSessionConfiguration, decoder: JSONDecoder) {
        session = URLSession(configuration: configuration)
        self.decoder = decoder
        logger = Logger()
    }

    // MARK: Public

    public func request<T: Decodable>(
        _ method: HTTPMethod,
        _ route: Routable,
        parameters: [String: Any]? = nil,
    ) async throws -> T {
        let request = urlRequest(method: method, route: route, parameters: parameters)
        let (data, response) = try await session.data(for: request)

        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
        let status = ResponseType(fromCode: statusCode)

        guard status == .succeed else {
            throw APIError(response: nil, status: status) ?? .unknownError
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            logger.debug("\(error)")
            throw error
        }
    }

    // MARK: Private

    private let session: URLSession
    private let decoder: JSONDecoder
    private let logger: Logger

    private func urlRequest(method: HTTPMethod, route: Routable, parameters: [String: Any]? = nil) -> URLRequest {
        var request = URLRequest(url: route.url)
        request.httpMethod = method.rawValue

        for (key, value) in route.extraHTTPHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return apiURLEncodedInURL(request: request, parameters: parameters).0
    }

}
