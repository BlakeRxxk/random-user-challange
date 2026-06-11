//
//  UsersListInteractor+PaginationState.swift
//  UsersList
//

import Foundation

extension UsersListInteractor {
    struct PaginationState {
        var page = 1
        var isLoading = false
        var hasMore = true

        var canLoadNextPage: Bool {
            !isLoading && hasMore
        }

        mutating func reset() {
            page = 1
            isLoading = false
            hasMore = true
        }

        mutating func startLoading() {
            isLoading = true
        }

        mutating func finishLoading() {
            page += 1
            isLoading = false
            hasMore = true
        }
    }
}
