//
//  RootRouter.swift
//  RUCApp
//

import RUCCore
import UIKit
import UsersList

// MARK: - RootInteractable

protocol RootInteractable: Interactable, UsersListListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

// MARK: - RootViewControllable

@MainActor
protocol RootViewControllable: ViewControllable { }

// MARK: - RootRouter

@MainActor
final class RootRouter: LaunchRouter<RootInteractor>, RootRouting {

    // MARK: Lifecycle

    init(usersListBuilder: UsersListBuildable, interactor: RootInteractor) {
        self.usersListBuilder = usersListBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    // MARK: Internal

    func routeToFeed() {
        usersListRouter = usersListBuilder.build(with: interactor)
        guard let viewController = usersListRouter?.viewControllable.uiViewController else { return }

        navigationController.setViewControllers([viewController], animated: false)
        setRootViewController(navigationController, animated: false)
    }

    func cleanupViews() { }

    // MARK: Private

    private lazy var navigationController = UINavigationController()

    private let usersListBuilder: UsersListBuildable
    private var usersListRouter: UsersListRouting?

}
