//
//  Street.swift
//  RandomUserDomain
//

import Foundation

public struct Street: Equatable, Sendable {
    public init(number: Int, name: String) {
        self.number = number
        self.name = name
    }

    public let number: Int
    public let name: String
}
