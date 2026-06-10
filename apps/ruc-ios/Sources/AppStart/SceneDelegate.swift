//
//  SceneDelegate.swift
//  RandomUserChallenge
//

import UIKit
import RUCApp
// MARK: - SceneDelegate

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        configureAppearance()
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidEnterBackground(_: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}

// MARK: - Private Methods

extension SceneDelegate {
    private func configureAppearance() { }
}
