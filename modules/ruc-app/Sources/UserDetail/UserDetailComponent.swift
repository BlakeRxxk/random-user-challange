//
//  UserDetailComponent.swift
//  UserDetail
//

import RandomUserData
import RandomUserDomain
import RUCCore
import RUCNetwork

// MARK: - UserDetailDependency

@MainActor
public protocol UserDetailDependency: Dependency {
    var usersRepository: RandomUserRepository { get }
}

// MARK: - UserDetailComponent

public final class UserDetailComponent: Component<UserDetailDependency> {
    public var usersRepository: RandomUserRepository {
        shared {
            dependency.usersRepository
        }
    }
}
