//
//  UsersListViewController+SearchableList.swift
//  UsersList
//

import RUCUI
import UIKit

// MARK: - UsersListViewController + SearchableList

extension UsersListViewController: SearchableList { }

// MARK: - UsersListViewController + UISearchResultsUpdating

extension UsersListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for _: UISearchController) { }
}

// MARK: - UsersListViewController + UISearchBarDelegate

extension UsersListViewController: UISearchBarDelegate {
    public func searchBar(_: UISearchBar, selectedScopeButtonIndexDidChange _: Int) {
//        listener?.change(scope: .init(rawValue: selectedScope) ?? .all)
    }

    public func searchBar(_: UISearchBar, textDidChange searchText: String) {
        listener?.search(with: searchText)
    }

    public func searchBarCancelButtonClicked(_: UISearchBar) {
        listener?.search(with: "")
    }
}
