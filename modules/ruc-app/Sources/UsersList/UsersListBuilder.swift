//
//  UsersListBuilder.swift
//  UsersList
//

import RUCCore

// MARK: - UsersListBuildable

@MainActor
public protocol UsersListBuildable {
    func build(with listener: some UsersListListener) -> UsersListRouting
}

// MARK: - UsersListBuilder

public final class UsersListBuilder: Builder<UsersListDependency>, UsersListBuildable {
    public func build(with listener: some UsersListListener) -> UsersListRouting {
        let component = UsersListComponent(dependency: dependency)

        let viewController = UsersListViewController()
        let interactor = UsersListInteractor(
            usersRepository: component.usersRepository,
            presenter: viewController,
        )

        interactor.listener = listener

        return UsersListRouter(
            userDetailBuilder: component.userDetailBuilder,
            interactor: interactor,
            viewController: viewController,
        )
    }
}
