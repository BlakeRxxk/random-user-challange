//
//  UsersListComponent.swift
//  UsersList
//

import RandomUserData
import RandomUserDomain
import RUCCore
import RUCNetwork

// MARK: - UsersListDependency

@MainActor
public protocol UsersListDependency: Dependency {
    var networkClient: HTTPClientProtocol { get }
}

// MARK: - UsersListComponent

public final class UsersListComponent: Component<UsersListDependency> {
    var usersRepository: RandomUserRepository {
        shared {
            RandomUserRepositoryImplementation(networkClient: .init(httpClient: dependency.networkClient),
                                               storage: InMemoryUserStorage())
//            RandomUserAPIClient(httpClient: dependency.networkClient)
        }
    }
}
