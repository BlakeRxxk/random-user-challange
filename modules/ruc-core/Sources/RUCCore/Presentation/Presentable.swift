//
//  Presentable.swift
//  RUCCore
//

// MARK: - Presentable

public protocol Presentable: AnyObject { }

// MARK: - Presenter

open class Presenter<ViewControllerType>: Presentable {

    // MARK: Lifecycle

    public init(viewController: ViewControllerType) {
        self.viewController = viewController
    }

    // MARK: Public

    public let viewController: ViewControllerType

}
