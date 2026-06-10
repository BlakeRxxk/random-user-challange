//
//  RandomUserResponseDTO.swift
//  RandomUserData
//

import Foundation

public struct RandomUserResponseDTO: Codable {
    public let results: [UserDTO]
    public let info: InfoDTO
}
