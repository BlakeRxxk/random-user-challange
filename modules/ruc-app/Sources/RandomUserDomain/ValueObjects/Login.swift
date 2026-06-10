//
//  Login.swift
//  RandomUserDomain
//

import Foundation

public struct Login: Equatable, Sendable {
    public init(uuid: UUID, username: String, password: String, salt: String, md5: String, sha1: String, sha256: String) {
        self.uuid = uuid
        self.username = username
        self.password = password
        self.salt = salt
        self.md5 = md5
        self.sha1 = sha1
        self.sha256 = sha256
    }

    public let uuid: UUID
    public let username: String
    public let password: String
    public let salt: String
    public let md5: String
    public let sha1: String
    public let sha256: String
}
