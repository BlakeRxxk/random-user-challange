//
//  RootDependency.swift
//  RUCApp
//

import Foundation
import RUCCore
import RUCNetwork

import RandomUserData
import RandomUserDomain

import UserDetail
import UsersList

private let kRequestTimeout = 20.0

// MARK: - RootDependency

public protocol RootDependency: Dependency {
    var coreDataStorage: RandomUserStorage { get }
}

// MARK: - RootComponent

public final class RootComponent: Component<RootDependency>, UsersListDependency, UserDetailDependency {

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
        shared {
            RandomUserRepositoryImplementation(
                networkClient: .init(httpClient: networkClient),
                storage: dependency.coreDataStorage,
            )
        }
    }

    public var usersListBuilder: UsersListBuildable {
        UsersListBuilder(dependency: self)
    }

    public var userDetailBuilder: UserDetailBuildable {
        UserDetailBuilder(dependency: self)
    }

}
