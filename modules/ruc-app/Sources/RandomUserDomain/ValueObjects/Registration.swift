//
//  Registration.swift
//  RandomUserDomain
//

import Foundation

public struct Registration: Equatable, Sendable {
    public init(date: Date, age: Int) {
        self.date = date
        self.age = age
    }

    public let date: Date
    public let age: Int
}
