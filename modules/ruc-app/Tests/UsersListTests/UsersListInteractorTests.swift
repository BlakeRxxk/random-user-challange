//
//  UsersListInteractorTests.swift
//  UsersListTests
//

import RandomUserDomain
import RUCCore
import XCTest
@testable import UsersList

// swiftlint:disable implicitly_unwrapped_optional

@MainActor
final class UsersListInteractorTests: XCTestCase {

    // MARK: Internal

    override func setUp() async throws {
        repository = RandomUserRepositoryMock()
        presenter = UsersListPresentableMock()
        router = UsersListRouterMock()
        sut = UsersListInteractor(usersRepository: repository, presenter: presenter)
        sut.router = router
        await MainActor.run {
            sut.router = router
        }
    }

    override func tearDown() async throws {
        sut = nil
        presenter = nil
        repository = nil
        router = nil
        try await super.tearDown()
    }

    func test_fetchUsers_resetsPageToOne() async {
        // Given — simulate being on page 3
        let users = User.makeList(40)
        repository.fetchUsersResult = .success(users)
        sut.fetchUsers()
        await Task.yield()
        sut.fetchNextPageUsers()
        await Task.yield()

        // When
        sut.fetchUsers()
        await Task.yield()

        // Then — last call should be page 1 again
        XCTAssertEqual(repository.fetchUsersReceivedPages.last, 1)
    }

    func test_fetchUsers_displaysUsers() async {
        // Given
        let users = User.makeList(3)
        repository.fetchUsersResult = .success(users)

        let expectation = expectation(description: "fetchUsers called")
        repository.onFetchUsers = { expectation.fulfill() }

        // When
        sut.fetchUsers()

        // Then
        await fulfillment(of: [expectation], timeout: 1.0)

        XCTAssertEqual(presenter.lastDisplayedUsers?.count, 3)
    }

    func test_fetchNextPageUsers_doesNotFetch_whileLoading() async {
        // Given — trigger page 1, don't yield so it's still in flight
        let users = User.makeList(40)
        repository.fetchUsersResult = .success(users)
        sut.fetchUsers()

        // When — try to load next page immediately
        sut.fetchNextPageUsers()
        await Task.yield()

        // Then — only one fetch call
        XCTAssertEqual(repository.fetchUsersCallCount, 1)
    }

    func test_fetchNextPageUsers_stopsWhenNoMore() async {
        // Given — server returns fewer than page size (last page)
        let users = User.makeList(10)
        repository.fetchUsersResult = .success(users)
        sut.fetchUsers()
        await Task.yield()

        // When
        sut.fetchNextPageUsers()
        await Task.yield()

        // Then — no second fetch
        XCTAssertEqual(repository.fetchUsersCallCount, 1)
    }

    func test_fetchNextPageUsers_doesNotFetch_afterReset() async {
        // Given — reach page 2
        let users = User.makeList(40)
        repository.fetchUsersResult = .success(users)
        sut.fetchUsers()
        await Task.yield()
        sut.fetchNextPageUsers()
        await Task.yield()

        // When — refresh resets, then next page fires before task settles
        sut.fetchUsers()
        sut.fetchNextPageUsers() // should be blocked by isLoading
        await Task.yield()

        // Then — page 1 again, not page 3
        XCTAssertEqual(repository.fetchUsersReceivedPages.last, 1)
    }

    func test_search_callsRepository_withQuery() async {
        // Given
        repository.searchUsersResult = .success([.make(firstName: "Alice")])

        // When
        sut.search(with: "Alice")
        // wait for debounce (300ms) + task
        try? await Task.sleep(nanoseconds: 350_000_000)

        // Then
        XCTAssertEqual(repository.searchUsersCallCount, 1)
        XCTAssertEqual(repository.searchUsersReceivedQuery, "Alice")
        XCTAssertEqual(presenter.lastDisplayedUsers?.count, 1)
    }

    func test_search_debounces_rapidCalls() async {
        // Given
        repository.searchUsersResult = .success([])

        // When — rapid inputs
        sut.search(with: "A")
        sut.search(with: "Al")
        sut.search(with: "Ali")
        sut.search(with: "Alic")
        sut.search(with: "Alice")
        try? await Task.sleep(nanoseconds: 350_000_000)

        // Then — only last query hits repository
        XCTAssertEqual(repository.searchUsersCallCount, 1)
        XCTAssertEqual(repository.searchUsersReceivedQuery, "Alice")
    }

    func test_search_displaysError_onFailure() async {
        // Given
        repository.searchUsersResult = .failure(URLError(.badServerResponse))

        // When
        sut.search(with: "fail")
        try? await Task.sleep(nanoseconds: 350_000_000)

        // Then
        XCTAssertEqual(presenter.displayErrorCallCount, 1)
    }

    func test_delete_displaysUpdatedList() async {
        // Given
        let remaining = User.makeList(2)
        repository.deleteUserResult = remaining

        // When
        sut.delete(user: "some-id")
        try? await Task.sleep(nanoseconds: 350_000_000)

        // Then
        XCTAssertEqual(presenter.lastDisplayedUsers?.count, 2)
        XCTAssertEqual(repository.deleteUserReceivedID, "some-id")
    }

    func test_select_routesToDetail() {
        // When
        sut.select(user: "abc-123")

        // Then
        XCTAssertEqual(router.routeToDetailCallCount, 1)
        XCTAssertEqual(router.routeToDetailUserID, "abc-123")
    }

    func test_onDismiss_dismissesUserDetail() {
        // When
        sut.onDismiss()

        // Then
        XCTAssertEqual(router.dismissUserDetailCallCount, 1)
    }

    // MARK: Private

    private var repository: RandomUserRepositoryMock!
    private var presenter: UsersListPresentableMock!
    private var router: UsersListRouterMock!
    private var sut: UsersListInteractor!
}
