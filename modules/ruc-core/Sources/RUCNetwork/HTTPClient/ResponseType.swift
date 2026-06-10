//
//  ResponseType.swift
//  RUCCore
//

import Foundation

// MARK: - ResponseType

public enum ResponseType: Sendable {
    case succeed
    case badRequest
    case unauthorized
    case upgradeRequired
    case forbidden
    case gone
    case canceled
    case unprocessable
    case notFound
    case unknownError
    case clientTimeOut
    case notConnected
    case conflict
    case internalError
    case badGateway
    case serviceUnavailable
    case requestTimeOut
    case gatewayTimeOut

    // MARK: Lifecycle

    public init(fromCode code: Int) {
        if code >= 200, code < 300 {
            self = .succeed
            return
        }

        self = kErrorMap[code] ?? .unknownError
    }
}

private let kErrorMap: [Int: ResponseType] = [
    400: .badRequest,
    401: .unauthorized,
    403: .forbidden,
    404: .notFound,
    408: .requestTimeOut,
    409: .conflict,
    410: .gone,
    422: .unprocessable,
    426: .upgradeRequired,
    500: .internalError,
    502: .badGateway,
    503: .serviceUnavailable,
    504: .gatewayTimeOut,
    NSURLErrorCancelled: .canceled,
    NSURLErrorTimedOut: .clientTimeOut,
    NSURLErrorNotConnectedToInternet: .notConnected,
]
