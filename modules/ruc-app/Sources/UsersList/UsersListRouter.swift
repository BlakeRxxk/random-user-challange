//
//  UsersListRouter.swift
//  UsersList
//

import RUCCore
import UIKit
import UserDetail

// MARK: - UsersListInteractable

protocol UsersListInteractable: Interactable, UserDetailListener {
    var router: UsersListRouting? { get set }
    var listener: UsersListListener? { get set }
}

// MARK: - UsersListViewControllable

@MainActor
protocol UsersListViewControllable: ViewControllable { }

// MARK: - UsersListRouter

@MainActor
final class UsersListRouter: ViewableRouter<UsersListInteractor, UsersListViewController> {

    // MARK: Lifecycle

    init(
        userDetailBuilder: UserDetailBuildable,
        interactor: UsersListInteractor,
        viewController: UsersListViewController,
    ) {
        self.userDetailBuilder = userDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    // MARK: Private

    private let userDetailBuilder: UserDetailBuildable
    private var userDetailRouter: UserDetailRouting?

}

// MARK: UsersListRouting

extension UsersListRouter: UsersListRouting {
    func routeToDetail(for userID: String) {
        guard userDetailRouter == nil else { return }

        let router = userDetailBuilder.build(
            with: interactor,
            selected: userID,
        )
        userDetailRouter = router
        attach(child: router)
        let root = UINavigationController(rootViewController: router.viewControllable.uiViewController)
        viewController.uiViewController.present(root, animated: true)
    }

    func dismissUserDetail() {
        guard let router = userDetailRouter else { return }
        userDetailRouter = nil
        detach(child: router)
        viewController.uiViewController.dismiss(animated: true)
    }
}
