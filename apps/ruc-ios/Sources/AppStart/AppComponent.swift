//
//  AppComponent.swift
//  RandomUserChallenge
//

import RandomUserData
import RUCApp
import RUCCore

public final class AppComponent: Component<EmptyDependency>, RootDependency {

    // MARK: Lifecycle

    init() {
        super.init(dependency: EmptyComponent())
    }

    // MARK: Public

    public var coreDataStorage: RandomUserStorage {
        shared {
            PersistenceController.shared
        }
    }

    // MARK: Internal

    var rootBuilder: RootBuildable {
        RootBuilder(dependency: self)
    }

}
