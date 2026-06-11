//
//  SearchableList.swift
//  RUCUI
//

import UIKit

// MARK: - SearchableList

public protocol SearchableList: UISearchResultsUpdating & UISearchBarDelegate & UIViewController & UISearchControllerDelegate {
    func setupSearchController(with scropes: [String])
}

extension SearchableList {
    public func setupSearchController(with scopes: [String]) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = scopes

        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.delegate = self

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
