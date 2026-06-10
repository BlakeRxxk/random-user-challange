//
//  User.swift
//  RandomUserDomain
//

import Foundation

public struct User: Equatable, Sendable {

    // MARK: Lifecycle

    public init(
        id: UUID,
        gender: Gender,
        name: PersonName,
        location: Location,
        email: String,
        login: Login,
        dateOfBirth: DateOfBirth,
        registered: Registration,
        phone: String,
        cell: String,
        identifier: Identifier?,
        picture: Picture,
        nationality: String,
    ) {
        self.id = id
        self.gender = gender
        self.name = name
        self.location = location
        self.email = email
        self.login = login
        self.dateOfBirth = dateOfBirth
        self.registered = registered
        self.phone = phone
        self.cell = cell
        self.identifier = identifier
        self.picture = picture
        self.nationality = nationality
    }

    // MARK: Public

    public let id: UUID
    public let gender: Gender
    public let name: PersonName
    public let location: Location
    public let email: String
    public let login: Login
    public let dateOfBirth: DateOfBirth
    public let registered: Registration
    public let phone: String
    public let cell: String
    public let identifier: Identifier?
    public let picture: Picture
    public let nationality: String

}
