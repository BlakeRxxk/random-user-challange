//
//  UserDetailInteractor.swift
//  UserDetail
//

import RandomUserDomain
import RUCCore

// MARK: - UserDetailListener

public protocol UserDetailListener: AnyObject {
    @MainActor
    func onDismiss()
}

// MARK: - UserDetailRouting

public protocol UserDetailRouting: ViewableRouting { }

// MARK: - UserDetailPresentable

@MainActor
public protocol UserDetailPresentable: Presentable {
    var listener: UserDetailPresentableListener? { get set }

    func display(user: UserDetailDisplayModel)
}

// MARK: - UserDetailInteractor
// swiftlint:disable:next no_unchecked_sendable
final class UserDetailInteractor: PresentableInteractor<UserDetailPresentable>, UserDetailInteractable, @unchecked Sendable {

    // MARK: Lifecycle

    @MainActor
    init(
        selectedUser: String,
        usersRepository: RandomUserRepository,
        presenter: UserDetailPresentable,
    ) {
        self.selectedUser = selectedUser
        self.usersRepository = usersRepository
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: Internal

    weak var router: UserDetailRouting?
    weak var listener: UserDetailListener?

    override func didBecomeActive() {
        super.didBecomeActive()
        fetchUser(with: selectedUser)
    }

    // MARK: Private

    private let usersRepository: RandomUserRepository

    private var fetchingTask: Task<Void, Never>?

    private var selectedUser: String

    private func fetchUser(with userId: String) {
        fetchingTask?.cancel()
        fetchingTask = Task { [weak usersRepository] in
            do {
                let result = try await usersRepository?.fetchUser(with: userId)
                let model = UserDetailDisplayModel(user: result!)
                await MainActor.run {
                    presenter.display(user: model)
                }
            } catch { }
        }
    }

}

// MARK: UserDetailPresentableListener

extension UserDetailInteractor: UserDetailPresentableListener {
    @MainActor
    func onDismiss() {
        listener?.onDismiss()
    }
}
