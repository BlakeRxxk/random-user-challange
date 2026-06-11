//
//  UserDetailBuilder.swift
//  UserDetail
//

import RUCCore

// MARK: - UserDetailBuildable

@MainActor
public protocol UserDetailBuildable {
    func build(with listener: some UserDetailListener, selected userID: String) -> UserDetailRouting
}

// MARK: - UserDetailBuilder

public final class UserDetailBuilder: Builder<UserDetailDependency>, UserDetailBuildable {
    public func build(with listener: some UserDetailListener, selected _: String) -> UserDetailRouting {
        let component = UserDetailComponent(dependency: dependency)

        let viewController = UserDetailViewController()
        let interactor = UserDetailInteractor(
            usersRepository: component.usersRepository,
            presenter: viewController,
        )

        interactor.listener = listener

        return UserDetailRouter(interactor: interactor, viewController: viewController)
    }
}
