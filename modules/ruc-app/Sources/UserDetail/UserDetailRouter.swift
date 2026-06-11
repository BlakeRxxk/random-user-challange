//
//  UserDetailRouter.swift
//  UserDetail
//
import RUCCore

// MARK: - UserDetailInteractable

protocol UserDetailInteractable: Interactable {
    var router: UserDetailRouting? { get set }
    var listener: UserDetailListener? { get set }
}

// MARK: - UserDetailViewControllable

@MainActor
protocol UserDetailViewControllable: ViewControllable { }

// MARK: - UserDetailRouter

@MainActor
final class UserDetailRouter: ViewableRouter<UserDetailInteractor, UserDetailViewController> {

    override init(
        interactor: UserDetailInteractor,
        viewController: UserDetailViewController,
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

}

// MARK: UserDetailRouting

extension UserDetailRouter: UserDetailRouting {
    func routeToDetail(for userID: String) {
        print(userID)
    }
}
