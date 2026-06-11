//
//  RootDependency.swift
//  RUCApp
//

import Foundation
import RUCCore
import RUCNetwork
import UsersList

private let kRequestTimeout = 20.0

// MARK: - RootDependency

public protocol RootDependency: Dependency { }

// MARK: - RootComponent

public final class RootComponent: Component<RootDependency>, UsersListDependency {

    // MARK: Public

    public var networkClient: HTTPClientProtocol {
        shared {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.timeoutIntervalForRequest = kRequestTimeout
            configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return HTTPClient(configuration: configuration, decoder: decoder, logger: OSLogger())
        }
    }

    // MARK: Internal

    var usersListBuilder: UsersListBuildable {
        UsersListBuilder(dependency: self)
    }

}
