//
//  LaunchRouter.swift
//  RUCCore
//

import Foundation
import UIKit

// MARK: - LaunchRouting

public protocol LaunchRouting: Routing {
    @MainActor
    func launch(from window: UIWindow)
}

// MARK: - LaunchRouter

@MainActor
open class LaunchRouter<InteractorType: Interactable>: Router<InteractorType>, LaunchRouting {
    public private(set) weak var window: UIWindow?

    public final func launch(from window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
        load()
    }

    public func setRootViewController(_ viewController: UIViewController, animated: Bool = false) {
        guard let window else {
            assertionFailure("setRootViewController called before launch(from:)")
            return
        }
        guard animated else {
            window.rootViewController = viewController
            return
        }
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: { window.rootViewController = viewController },
        )
    }
}
