//
//  RootDependency.swift
//  RUCApp
//

import Foundation
import RUCCore
import RUCNetwork

import RandomUserDomain
import RandomUserData

import UsersList
import UserDetail

private let kRequestTimeout = 20.0

// MARK: - RootDependency

public protocol RootDependency: Dependency { }

// MARK: - RootComponent

public final class RootComponent: Component<RootDependency>, UsersListDependency, UserDetailDependency {

    // MARK: Public

    public var networkClient: HTTPClientProtocol {
        shared {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.timeoutIntervalForRequest = kRequestTimeout
            configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return HTTPClient(configuration: configuration, decoder: decoder)
        }
    }
    
    public var usersRepository: RandomUserRepository {
        RandomUserRepositoryImplementation(
            networkClient: .init(httpClient: networkClient),
            storage: InMemoryUserStorage(),
        )
    }

    public var usersListBuilder: UsersListBuildable {
        UsersListBuilder(dependency: self)
    }
    
    public var userDetailBuilder: UserDetailBuildable {
        UserDetailBuilder(dependency: self)
    }

}
