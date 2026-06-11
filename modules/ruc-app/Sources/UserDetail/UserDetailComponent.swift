//
//  UserDetailComponent.swift
//  UserDetail
//

import RandomUserDomain
import RUCCore

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
