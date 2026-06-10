//
//  InfoDTO.swift
//  RandomUserData
//

import Foundation

public struct InfoDTO: Codable {
    public let seed: String
    public let results: Int
    public let page: Int
    public let version: String
}
