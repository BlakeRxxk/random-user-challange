//
//  Builder.swift
//  RUCCore
//

import Foundation

// MARK: - Buildable

public protocol Buildable: AnyObject { }

// MARK: - Builder

open class Builder<DependencyType>: Buildable {

    // MARK: Lifecycle

    public init(dependency: DependencyType) {
        self.dependency = dependency
    }

    // MARK: Public

    public let dependency: DependencyType

}
