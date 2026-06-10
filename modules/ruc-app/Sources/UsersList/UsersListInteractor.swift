//
//  UsersListInteractor.swift
//  UsersList
//

import RUCCore

// MARK: - UsersListListener

public protocol UsersListListener: AnyObject { }

// MARK: - UsersListRouting

public protocol UsersListRouting: ViewableRouting { }

// MARK: - UsersListPresentable

@MainActor
public protocol UsersListPresentable: Presentable {
    var listener: UsersListPresentableListener? { get set }
}

// MARK: - UsersListInteractor

final class UsersListInteractor: PresentableInteractor<UsersListPresentable>, UsersListInteractable, @unchecked Sendable {

    weak var router: UsersListRouting?
    weak var listener: UsersListListener?

}

// MARK: UsersListPresentableListener

extension UsersListInteractor: UsersListPresentableListener { }
