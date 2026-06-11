//
//  UsersListInteractor.swift
//  UsersList
//

import RandomUserDomain
import RUCCore
import UserDetail

// MARK: - UsersListListener

public protocol UsersListListener: AnyObject { }

// MARK: - UsersListRouting
@MainActor
public protocol UsersListRouting: ViewableRouting {
    func routeToDetail(for userID: String)
    func dismissUserDetail()
}

// MARK: - UsersListPresentable

@MainActor
public protocol UsersListPresentable: Presentable {
    var listener: UsersListPresentableListener? { get set }

    func display(users: [UserCellModel])
    func displayError()
}

// MARK: - UsersListInteractor
// swiftlint:disable:next no_unchecked_sendable
final class UsersListInteractor: PresentableInteractor<UsersListPresentable>, @unchecked Sendable {

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

    deinit {
        fetchingTask?.cancel()
        searchTask?.cancel()
        deletionTask?.cancel()
    }

    // MARK: Internal

    weak var router: UsersListRouting?
    weak var listener: UsersListListener?

    // MARK: Private

    private let usersRepository: RandomUserRepository

    private var fetchingTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?
    private var deletionTask: Task<Void, Never>?

    private var paginationState = PaginationState()

}

// MARK: UsersListPresentableListener

extension UsersListInteractor: UsersListPresentableListener {

    // MARK: Internal

    func fetchUsers() {
        fetchingTask?.cancel()
        paginationState.reset()
        fetchPage()
    }

    func fetchNextPageUsers() {
        guard paginationState.canLoadNextPage else { return }
        fetchPage()
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
        router?.routeToDetail(for: userID)
    }

    func delete(user userID: String) {
        deletionTask?.cancel()
        deletionTask = Task { [weak usersRepository] in
            let result = await usersRepository?.deleteUser(with: userID)
            let models = result?.compactMap(UserCellModel.init) ?? []
            await MainActor.run {
                presenter.display(users: models)
            }
        }
    }

    // MARK: Private

    private func resetState() {
        paginationState.reset()
    }

    private func fetchPage() {
        paginationState.startLoading()
        let page = paginationState.page

        fetchingTask = Task { [weak self] in
            guard let self else { return }
            do {
                let result = try await usersRepository.fetchUsers(page: page, results: 40)
                let models = result.compactMap(UserCellModel.init)
                await MainActor.run {
                    self.paginationState.finishLoading(receivedCount: models.count, pageSize: 40)
                    self.presenter.display(users: models)
                }
            } catch {
                await MainActor.run {
                    self.paginationState.isLoading = false
                    self.presenter.displayError()
                }
            }
        }
    }

}

// MARK: UsersListInteractable

extension UsersListInteractor: UsersListInteractable {
    @MainActor
    func onDismiss() {
        router?.dismissUserDetail()
    }
}
