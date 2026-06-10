//
//  UsersListComponent.swift
//  UsersList
//

import RUCCore

// MARK: - UsersListDependency

@MainActor
public protocol UsersListDependency: Dependency { }

// MARK: - UsersListComponent

public final class UsersListComponent: Component<UsersListDependency> { }
