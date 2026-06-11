//
//  UsersListView.swift
//  UsersList
//

import Foundation
import RUCUI
import UIKit

public final class UsersListView: BaseListView {

    // MARK: Public

    public enum Section: Sendable {
        case main
    }

    override public func createUI() {
        super.createUI()
        configureRefreshControl()
        configureCellRegistration()
        collectionView?.contentInset.bottom = bottomInset
    }

    // MARK: Internal

    let refreshControl = UIRefreshControl()

    // MARK: Private

    private var bottomInset: CGFloat {
        safeAreaInsets.bottom > 0 ? 0 : 16
    }

    private func configureRefreshControl() {
//        refreshControl.tintColor = .text(.secondary)
        collectionView?.refreshControl = refreshControl
    }

    private func configureCellRegistration() {
        collectionView?.register(
            UserRowCell.self,
            forCellWithReuseIdentifier: UserRowCell.reuseIdentifier,
        )
        collectionView?.selfSizingInvalidation = .enabledIncludingConstraints
    }

}
