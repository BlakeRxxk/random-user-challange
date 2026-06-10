//
//  RootListener.swift
//  RUCApp
//

import RUCCore

// MARK: - RootListener

protocol RootListener: AnyObject { }

// MARK: - RootRouting

protocol RootRouting: AnyObject {
    @MainActor
    func routeToFeed()
    @MainActor
    func cleanupViews()
}

// MARK: - RootInteractor
// swiftlint:disable:next no_unchecked_sendable
final class RootInteractor: Interactor, RootInteractable, @unchecked Sendable {

    // MARK: Lifecycle

    override init() { }

    // MARK: Internal

    weak var router: RootRouting?
    weak var listener: RootListener?

    override func didBecomeActive() {
        super.didBecomeActive()

        Task { @MainActor [weak router] in
            router?.routeToFeed()
        }
    }

    override func willResignActive() {
        super.willResignActive()

        Task { @MainActor [weak router] in
            router?.cleanupViews()
        }
    }

}
