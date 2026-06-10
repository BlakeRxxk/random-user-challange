//
//  PersonName.swift
//  RandomUserDomain
//

import Foundation

public struct PersonName: Equatable, Sendable {
    public init(title: String, first: String, last: String) {
        self.title = title
        self.first = first
        self.last = last
    }

    public let title: String
    public let first: String
    public let last: String
}
