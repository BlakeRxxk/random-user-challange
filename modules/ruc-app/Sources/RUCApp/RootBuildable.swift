//
//  RootBuildable.swift
//  RUCApp
//

import RUCCore

// MARK: - RootBuildable

public protocol RootBuildable: Buildable {
    @MainActor
    func build() -> any LaunchRouting
}

// MARK: - RootBuilder

public final class RootBuilder: Builder<RootDependency>, RootBuildable {
    @MainActor
    public func build() -> any LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let interactor = RootInteractor()

        return RootRouter(usersListBuilder: component.usersListBuilder, interactor: interactor)
    }
}
