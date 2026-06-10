//
//  LocationDTO.swift
//  RandomUserData
//

import Foundation

public struct LocationDTO: Codable {
    public let street: StreetDTO
    public let city: String
    public let state: String
    public let country: String
    public let postcode: PostcodeDTO
    public let coordinates: CoordinatesDTO
    public let timezone: TimezoneDTO
}
