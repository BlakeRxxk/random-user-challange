//
//  UsersListViewController.swift
//  UsersList
//

import RUCCore
import RUCUI
import UIKit

private typealias UsersDataSource = UICollectionViewDiffableDataSource<UsersListView.Section, UserCellModel>
private typealias UsersSnapshot = NSDiffableDataSourceSnapshot<UsersListView.Section, UserCellModel>

// MARK: - UsersListPresentableListener

public protocol UsersListPresentableListener: AnyObject {
    func fetchUsers()
    func search(with text: String)
    func delete(user userID: String)
    @MainActor
    func select(user userID: String)
}

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

    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Localized.title

        configureDataSource()
        configureSwipeActions()
        specializedView.collectionView?.delegate = self
        specializedView.collectionView?.prefetchDataSource = self
        specializedView.refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchController(with: [])
        listener?.fetchUsers()
    }

    // MARK: Private

    private var dataSource: UsersDataSource?

    @objc
    private func handleRefresh(_: UIRefreshControl) {
        listener?.fetchUsers()
    }

    private func configureDataSource() {
        guard let collectionView = specializedView.collectionView else { return }
        dataSource = UsersDataSource(
            collectionView: collectionView,
            cellProvider: cellProvider,
        )

        var snapshot = UsersSnapshot()
        snapshot.appendSections([UsersListView.Section.main])
        snapshot.appendItems([])
    }

    private func cellProvider(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ model: UserCellModel,
    ) -> UICollectionViewCell? {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserRowCell.reuseIdentifier,
                for: indexPath,
            ) as? UserRowCell
        else { return nil }
        cell.configure(with: model)
        cell.output = self
        return cell
    }

    private func updateSnapshot(with users: [UserCellModel]) {
        var snapshot = UsersSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func configureSwipeActions() {
        specializedView.swipeActionsProvider = { [weak self] indexPath in
            guard let self else { return nil }

            guard let user = dataSource?.itemIdentifier(for: indexPath) else {
                return nil
            }

            let delete = UIContextualAction(
                style: .destructive,
                title: Localized.delete,
            ) { [weak listener] _, _, completion in
                listener?.delete(user: user.id)
                completion(true)
            }

            return UISwipeActionsConfiguration(actions: [delete])
        }
    }

}

// MARK: UICollectionViewDelegate

extension UsersListViewController: UICollectionViewDelegate { }

// MARK: UICollectionViewDataSourcePrefetching

extension UsersListViewController: UICollectionViewDataSourcePrefetching {
    public func collectionView(_: UICollectionView, prefetchItemsAt _: [IndexPath]) {
        //
    }
}

// MARK: UsersListPresentable

extension UsersListViewController: UsersListPresentable {

    // MARK: Public

    public func display(users: [UserCellModel]) {
        specializedView.refreshControl.endRefreshing()
        updateSnapshot(with: users)

        if users.isEmpty {
            displayEmptyState()
        } else {
            contentUnavailableConfiguration = nil
        }
    }

    public func displayError() {
        var errorConfig = UIContentUnavailableConfiguration.empty()
        errorConfig.image = UIImage(systemName: "exclamationmark.circle.fill")
        errorConfig.text = "Something went wrong."
        errorConfig.secondaryText = "Please try again later."

        // Create configuration for reload button
        var retryButtonConfig = UIButton.Configuration.plain()
        retryButtonConfig.title = "Try again"
        errorConfig.button = retryButtonConfig

        // Define the reload button action
        errorConfig.buttonProperties.primaryAction = UIAction { [weak listener] _ in
            listener?.fetchUsers()
        }

        contentUnavailableConfiguration = errorConfig
    }

    // MARK: Private

    private func displayEmptyState() {
        var configuration = UIContentUnavailableConfiguration.empty()
        configuration.text = "No Results"
        configuration.image = UIImage(systemName: "magnifyingglass")
        configuration.secondaryText = "Try a different query."

        contentUnavailableConfiguration = configuration
    }

}

// MARK: UserRowCellOutput

extension UsersListViewController: UserRowCellOutput {
    func didTapButton(with viewModel: UserCellModel) {
        listener?.select(user: viewModel.id)
    }
}

// MARK: UsersListViewController.Localized

extension UsersListViewController {
    fileprivate enum Localized {
        static let title = "Random Users".localize()
        static let delete = "Delete".localize()
    }
}
