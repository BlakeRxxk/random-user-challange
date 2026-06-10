//
//  Timezone.swift
//  RandomUserDomain
//

import Foundation

public struct Timezone: Equatable, Sendable {
    public init(offset: String, description: String) {
        self.offset = offset
        self.description = description
    }

    public let offset: String
    public let description: String
}
