//
//  Picture.swift
//  RandomUserDomain
//

import Foundation

public struct Picture: Equatable, Sendable {
    public init(large: URL, medium: URL, thumbnail: URL) {
        self.large = large
        self.medium = medium
        self.thumbnail = thumbnail
    }

    public let large: URL
    public let medium: URL
    public let thumbnail: URL
}
