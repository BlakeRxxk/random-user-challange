//
//  DateOfBirth.swift
//  RandomUserDomain
//

import Foundation

public struct DateOfBirth: Equatable, Sendable {
    public init(date: Date, age: Int) {
        self.date = date
        self.age = age
    }

    public let date: Date
    public let age: Int
}
