//
//  Coordinates.swift
//  RandomUserDomain
//

import Foundation

public struct Coordinates: Equatable, Sendable {
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    public let latitude: Double
    public let longitude: Double
}
