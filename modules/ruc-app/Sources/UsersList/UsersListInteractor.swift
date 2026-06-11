//
//  UsersListInteractor.swift
//  UsersList
//

import RandomUserDomain
import RUCCore

// MARK: - UsersListListener

public protocol UsersListListener: AnyObject { }

// MARK: - UsersListRouting

public protocol UsersListRouting: ViewableRouting {
    func routeToDetail(for userID: String)
}

// MARK: - UsersListPresentable

@MainActor
public protocol UsersListPresentable: Presentable {
    var listener: UsersListPresentableListener? { get set }

    func display(users: [UserCellModel])
    func displayError()
}

// MARK: - UsersListInteractor

final class UsersListInteractor: PresentableInteractor<UsersListPresentable>, UsersListInteractable, @unchecked Sendable {

    // MARK: Lifecycle

    @MainActor
    init(
        usersRepository: RandomUserRepository,
        presenter: UsersListPresentable,
    ) {
        self.usersRepository = usersRepository
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: Internal

    weak var router: UsersListRouting?
    weak var listener: UsersListListener?

    // MARK: Private

    private let usersRepository: RandomUserRepository

    private var fetchingTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?

}

// MARK: UsersListPresentableListener

extension UsersListInteractor: UsersListPresentableListener {

    func fetchUsers() {
        fetchingTask?.cancel()
        fetchingTask = Task { [weak usersRepository] in
            do {
                let result = try await usersRepository?.fetchUsers(page: 1, results: 40)
                let models = result?.compactMap(UserCellModel.init) ?? []
                await MainActor.run {
                    presenter.display(users: models)
                }
            } catch {
                await MainActor.run {
                    presenter.displayError()
                }
            }
        }
    }

    func search(with text: String) {
        searchTask?.cancel()
        searchTask = Task { [weak usersRepository] in
            try? await Task.sleep(nanoseconds: 300_000_000)
            guard !Task.isCancelled else { return }

            do {
                let result = try await usersRepository?.searchUsers(query: text)
                let models = result?.compactMap(UserCellModel.init) ?? []
                await MainActor.run {
                    presenter.display(users: models)
                }

            } catch {
                await MainActor.run {
                    presenter.displayError()
                }
            }
        }
    }

    @MainActor
    func select(user userID: String) {
        print(router)
        router?.routeToDetail(for: userID)
    }

}
