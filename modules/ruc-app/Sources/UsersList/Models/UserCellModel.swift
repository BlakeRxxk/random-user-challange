//
//  UserCellModel.swift
//  UsersList
//

import Foundation
import RandomUserDomain
import RUCCore

// MARK: - UserCellModel

public struct UserCellModel: Hashable, Identifiable, Sendable {
    public init(id: String, name: String, cell: String, avatarURL: URL?) {
        self.id = id
        self.name = name
        phone = cell
        self.avatarURL = avatarURL
    }

    public let id: String
    public let name: String
    public let phone: String
    public let avatarURL: URL?
}

extension UserCellModel {
    public init(user: User) {
        self.init(id: user.id.uuidString, name: user.name.first, cell: user.cell, avatarURL: user.picture.medium)
    }
}
