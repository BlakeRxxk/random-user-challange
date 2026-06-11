//
//  UserDetailModel.swift
//  UserDetail
//

import Foundation
import Observation
import RandomUserDomain

// MARK: - UserDetailModel

@Observable
public final class UserDetailModel {
    var displayModel: UserDetailDisplayModel?
}

// MARK: - UserDetailDisplayModel

public struct UserDetailDisplayModel {

    // MARK: Lifecycle

    public init(
        gender: String,
        firstName: String,
        lastName: String,
        address: String,
        registration: String,
        email: String,
        avatarURL: URL,
    ) {
        self.gender = gender
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.registration = registration
        self.email = email
        self.avatarURL = avatarURL
    }

    // MARK: Internal

    let gender: String
    let firstName: String
    let lastName: String
    let address: String
    let registration: String
    let email: String
    let avatarURL: URL

}

extension UserDetailDisplayModel {
    public init(user: User) {
        let registrationDate = user.registered.date
            .formatted()
        let address = "\(user.location.state), \(user.location.city), \(user.location.street.name), \(user.location.street.number)"
        self.init(
            gender: user.gender.rawValue,
            firstName: user.name.first,
            lastName: user.name.last,
            address: address,
            registration: registrationDate,
            email: user.email,
            avatarURL: user.picture.medium,
        )
    }
}
