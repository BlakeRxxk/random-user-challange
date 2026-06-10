//
//  UserDTO.swift
//  RandomUserData
//

import Foundation

public struct UserDTO: Codable {
    public let gender: String
    public let name: NameDTO
    public let location: LocationDTO
    public let email: String
    public let login: LoginDTO
    public let dob: DOBDTO
    public let registered: RegisteredDTO
    public let phone: String
    public let cell: String
    public let id: IDDTO
    public let picture: PictureDTO
    public let nat: String
}
