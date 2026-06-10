//
//  UsersListViewController.swift
//  UsersList
//

import RUCUI
import UIKit

// MARK: - UsersListPresentableListener

public protocol UsersListPresentableListener: AnyObject { }

// MARK: - UsersListViewController

public final class UsersListViewController: ViewController<UsersListView>, UsersListViewControllable {

    // MARK: Lifecycle

    init(listener: UsersListPresentableListener? = nil) {
        self.listener = listener
        super.init(viewCreator: UsersListView.init)
    }

    // MARK: Public

    public weak var listener: UsersListPresentableListener?

    public var uiViewController: UIViewController {
        self
    }

}

// MARK: UsersListPresentable

extension UsersListViewController: UsersListPresentable { }
