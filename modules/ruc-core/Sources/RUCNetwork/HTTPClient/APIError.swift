//
//  APIError.swift
//  RUCCore
//

import Foundation

public struct APIError: Error {

    // MARK: Lifecycle

    init(_ reason: String, message: String? = nil) {
        self.reason = reason
        self.message = message
        status = nil
    }

    init?(response: NSDictionary?, status: ResponseType) {
        self.status = status

        if status == .succeed {
            return nil
        }

        reason = response?["error"] as? String ?? APIError.unknownError.reason
        message = response?["error_description"] as? String
    }

    // MARK: Public

    public let message: String?
    public let reason: String
    public let status: ResponseType?

    // MARK: Internal

    static let unknownError = APIError("unknown")
    static let parsingError = APIError("parsingError")

}
