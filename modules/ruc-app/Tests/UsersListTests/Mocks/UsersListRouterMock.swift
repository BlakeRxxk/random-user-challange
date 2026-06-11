//
//  UsersListRouterMock.swift
//  UsersListTests
//

import RandomUserDomain
import RUCCore
import UsersList
@MainActor
final class UsersListRouterMock: @MainActor UsersListRouting {
    var viewControllable: ViewControllable = ViewControllableMock()
    var interactable: any Interactable = InteractableMock()
    var children = [any Routing]()

    private(set) var routeToDetailCallCount = 0
    private(set) var routeToDetailUserID: String?
    private(set) var dismissUserDetailCallCount = 0

    func load() { }
    func attach(child _: any Routing) { }
    func detach(child _: any Routing) { }

    func routeToDetail(for userID: String) {
        routeToDetailCallCount += 1
        routeToDetailUserID = userID
    }

    func dismissUserDetail() {
        dismissUserDetailCallCount += 1
    }
}
