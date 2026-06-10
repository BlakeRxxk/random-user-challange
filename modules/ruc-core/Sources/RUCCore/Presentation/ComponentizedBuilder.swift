//
//  ComponentizedBuilder.swift
//  RUCCore
//

import Foundation

// MARK: - ComponentizedBuilder

open class ComponentizedBuilder<Component, Router, DynamicBuildDependency, DynamicComponentDependency>: Buildable {

    // MARK: Lifecycle

    public init(componentBuilder: @escaping (DynamicComponentDependency) -> Component) {
        self.componentBuilder = componentBuilder
    }

    // MARK: Open

    open func build(with _: Component, _: DynamicBuildDependency) -> Router {
        fatalError("This method should be overridden by the subclass.")
    }

    // MARK: Public

    public final func build(withDynamicBuildDependency dynamicBuildDependency: DynamicBuildDependency, dynamicComponentDependency: DynamicComponentDependency) -> Router {
        build(withDynamicBuildDependency: dynamicBuildDependency, dynamicComponentDependency: dynamicComponentDependency).1
    }

    public final func build(
        withDynamicBuildDependency dynamicBuildDependency: DynamicBuildDependency,
        dynamicComponentDependency: DynamicComponentDependency,
    ) -> (Component, Router) {
        let component = componentBuilder(dynamicComponentDependency)

        // Ensure each componentBuilder invocation produces a new component
        // instance.
        let newComponent = component as AnyObject
        if lastComponent === newComponent {
            assertionFailure("\(self) componentBuilder should produce new instances of component when build is invoked.")
        }
        lastComponent = newComponent

        return (component, build(with: component, dynamicBuildDependency))
    }

    // MARK: Private

    private let componentBuilder: (DynamicComponentDependency) -> Component
    private weak var lastComponent: AnyObject?

}

// MARK: - SimpleComponentizedBuilder

/// A convenient base builder class that does not require any build or
/// component dynamic dependencies.
open class SimpleComponentizedBuilder<Component, Router>: ComponentizedBuilder<Component, Router, Void, Void> {

    // MARK: Lifecycle

    public init(componentBuilder: @escaping () -> Component) {
        super.init(componentBuilder: componentBuilder)
    }

    // MARK: Open

    open func build(with _: Component) -> Router {
        fatalError("This method should be overriden by the subclass.")
    }

    // MARK: Public

    /// This method should not be directly invoked.
    public final override func build(with component: Component, _: ()) -> Router {
        build(with: component)
    }

    /// Build a new instance of the RIB.
    ///
    /// - returns: The router of the RIB.
    public final func build() -> Router {
        build(withDynamicBuildDependency: (), dynamicComponentDependency: ())
    }

}
