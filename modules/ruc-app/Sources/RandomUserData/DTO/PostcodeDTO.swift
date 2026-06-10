//
//  PostcodeDTO.swift
//  RandomUserData
//

import Foundation

public enum PostcodeDTO: Codable {
    case int(Int)
    case string(String)

    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
            return
        }

        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
            return
        }

        throw DecodingError.typeMismatch(
            PostcodeDTO.self,
            .init(
                codingPath: decoder.codingPath,
                debugDescription: "Invalid postcode format",
            ),
        )
    }
}
