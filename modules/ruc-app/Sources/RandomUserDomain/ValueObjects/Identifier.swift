//
//  Identifier.swift
//  RandomUserDomain
//

import Foundation

public struct Identifier: Equatable, Sendable {
    public init(name: String?, value: String?) {
        self.name = name
        self.value = value
    }

    public let name: String?
    public let value: String?
}
