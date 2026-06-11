//
//  UserCellModel.swift
//  UsersList
//

import Foundation
import RandomUserDomain
import RUCCore

// MARK: - UserCellModel

public struct UserCellModel: Hashable, Identifiable, Sendable {
    public init(id: String, name: String, cell: String, email: String, avatarURL: URL?) {
        self.id = id
        self.name = name
        self.cell = cell
        self.email = email
        self.avatarURL = avatarURL
    }

    public let id: String
    public let name: String
    public let cell: String
    public let email: String
    public let avatarURL: URL?
}

extension UserCellModel {
    public init(user: User) {
        self.init(
            id: user.id.uuidString,
            name: "\(user.name.first) \(user.name.last)",
            cell: user.cell,
            email: user.email,
            avatarURL: user.picture.medium,
        )
    }
}
