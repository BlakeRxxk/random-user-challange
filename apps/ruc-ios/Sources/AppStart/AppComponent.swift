//
//  AppComponent.swift
//  RandomUserChallenge
//

import RUCApp
import RUCCore

public final class AppComponent: Component<EmptyDependency>, RootDependency {

    // MARK: Lifecycle

    init() {
        super.init(dependency: EmptyComponent())
    }

    // MARK: Internal

    var rootBuilder: RootBuildable {
        RootBuilder(dependency: self)
    }

}
