//
//  UsersListRouter.swift
//  UsersList
//

import RUCCore

// MARK: - UsersListInteractable

protocol UsersListInteractable: Interactable {
    var router: UsersListRouting? { get set }
    var listener: UsersListListener? { get set }
}

// MARK: - UsersListViewControllable

@MainActor
protocol UsersListViewControllable: ViewControllable { }

// MARK: - UsersListRouter

@MainActor
final class UsersListRouter: ViewableRouter<UsersListInteractor, UsersListViewController>, UsersListRouting { }
