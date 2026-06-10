//
//  PresentableInteractor.swift
//  RUCCore
//

import Foundation

/// Base class of an `Interactor` that actually has an associated `Presenter` and `View`.
// swiftlint:disable:next no_unchecked_sendable
open class PresentableInteractor<PresenterType>: Interactor, @unchecked Sendable {

    // MARK: Lifecycle

    public init(presenter: PresenterType) {
        self.presenter = presenter
    }

    // MARK: Public

    public let presenter: PresenterType

}
