//
//  Location.swift
//  RandomUserDomain
//

import Foundation

public struct Location: Equatable, Sendable {

    // MARK: Lifecycle

    public init(
        street: Street,
        city: String,
        state: String,
        country: String,
        postcode: Postcode,
        coordinates: Coordinates,
        timezone: Timezone,
    ) {
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.postcode = postcode
        self.coordinates = coordinates
        self.timezone = timezone
    }

    // MARK: Public

    public let street: Street
    public let city: String
    public let state: String
    public let country: String
    public let postcode: Postcode
    public let coordinates: Coordinates
    public let timezone: Timezone

}
