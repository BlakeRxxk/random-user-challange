//
//  Component.swift
//  RUCCore
//

import Foundation

// MARK: - Component
@MainActor
open class Component<DependencyType>: Dependency {

    // MARK: Lifecycle

    public init(dependency: DependencyType) {
        self.dependency = dependency
    }

    // MARK: Public

    public let dependency: DependencyType

    public final func shared<T>(__function: String = #function, _ factory: () -> T) -> T {
        lock.lock()
        defer {
            lock.unlock()
        }

        if let instance = (sharedInstances[__function] as? T?) ?? nil {
            return instance
        }

        let instance = factory()
        sharedInstances[__function] = instance

        return instance
    }

    // MARK: Private

    private var sharedInstances = [String: Any]()
    private let lock = NSRecursiveLock()

}

// MARK: - EmptyComponent

open class EmptyComponent: EmptyDependency {
    public init() { }
}
