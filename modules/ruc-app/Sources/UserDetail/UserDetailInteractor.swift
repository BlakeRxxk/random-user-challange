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
}

// MARK: - UserDetailInteractor
// swiftlint:disable:next no_unchecked_sendable
final class UserDetailInteractor: PresentableInteractor<UserDetailPresentable>, UserDetailInteractable, @unchecked Sendable {

    // MARK: Lifecycle

    @MainActor
    init(
        usersRepository: RandomUserRepository,
        presenter: UserDetailPresentable,
    ) {
        self.usersRepository = usersRepository
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: Internal

    weak var router: UserDetailRouting?
    weak var listener: UserDetailListener?

    // MARK: Private

    private let usersRepository: RandomUserRepository

    private var fetchingTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?

}

// MARK: UserDetailPresentableListener

extension UserDetailInteractor: UserDetailPresentableListener {
    @MainActor
    func onDismiss() {
        listener?.onDismiss()
    }
}
