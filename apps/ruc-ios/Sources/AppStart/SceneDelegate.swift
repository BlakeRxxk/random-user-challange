//
//  SceneDelegate.swift
//  RandomUserChallenge
//

import RUCApp
import RUCCore
import UIKit

// MARK: - SceneDelegate

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: Internal

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        launchRouter = buildLaunchRouter()
        configureAppearance()
        launchRouter?.launch(from: window)
        self.window = window
    }

    func sceneDidEnterBackground(_: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    // MARK: Private

    private var launchRouter: LaunchRouting?

}

// MARK: - Private Methods

extension SceneDelegate {

    private func buildLaunchRouter() -> LaunchRouting {
        AppComponent().rootBuilder.build()
    }

    private func configureAppearance() { }

}
