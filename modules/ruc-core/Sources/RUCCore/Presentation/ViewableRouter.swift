//
//  ViewableRouter.swift
//  RUCCore
//

import UIKit

// MARK: - ViewControllable

@MainActor
public protocol ViewControllable: AnyObject {
    var uiViewController: UIViewController { get }
}

// MARK: - ViewableRouting

@MainActor
public protocol ViewableRouting: Routing {
    var viewControllable: ViewControllable { get }
}

// MARK: - ViewableRouter

/// A router that owns a view controller.
@MainActor
open class ViewableRouter <
    InteractorType: Interactable,
    ViewControllerType: ViewControllable,
>: Router<InteractorType>, ViewableRouting {

    // MARK: Lifecycle

    public init(interactor: InteractorType, viewController: ViewControllerType) {
        self.viewController = viewController
        viewControllable = viewController
        super.init(interactor: interactor)
    }

    // MARK: Public

    public let viewController: ViewControllerType
    public var viewControllable: ViewControllable

}
