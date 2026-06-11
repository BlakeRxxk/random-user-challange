//
//  UsersListComponent.swift
//  UsersList
//

import RandomUserDomain
import RUCCore
import UserDetail

// MARK: - UsersListDependency

@MainActor
public protocol UsersListDependency: Dependency {
    var usersRepository: RandomUserRepository { get }
    var userDetailBuilder: UserDetailBuildable { get }
}

// MARK: - UsersListComponent

public final class UsersListComponent: Component<UsersListDependency> {

    // MARK: Public

    public var usersRepository: RandomUserRepository {
        shared {
            dependency.usersRepository
        }
    }

    // MARK: Internal

    var userDetailBuilder: UserDetailBuildable {
        dependency.userDetailBuilder
    }

}
