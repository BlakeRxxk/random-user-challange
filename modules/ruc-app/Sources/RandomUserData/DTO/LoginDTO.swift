//
//  LoginDTO.swift
//  RandomUserData
//

import Foundation

public struct LoginDTO: Codable {
    public let uuid: String
    public let username: String
    public let password: String
    public let salt: String
    public let md5: String
    public let sha1: String
    public let sha256: String
}
