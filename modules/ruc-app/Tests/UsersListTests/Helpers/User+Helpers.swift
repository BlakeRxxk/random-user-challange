//
//  User+Helpers.swift
//  UsersListTests
//

import Foundation
import RandomUserDomain

extension User {
    public static func make(
        id: UUID = .init(),
        firstName: String = "John",
        lastName: String = "Doe",
        email _: String = "john@doe.com",
    ) -> User {
        User(
            id: id,
            gender: .unknown,
            name: .init(title: "", first: firstName, last: lastName),
            location: .init(
                street: .init(number: 1, name: "Main"),
                city: "HH",
                state: "SH",
                country: "DE",
                postcode: .int(22100),
                coordinates: .init(latitude: 0.0, longitude: 0.0),
                timezone: .init(offset: "", description: ""),
            ),
            email: "",
            login: .init(uuid: UUID(), username: "", password: "", salt: "", md5: "", sha1: "", sha256: ""),
            dateOfBirth: .init(date: .now, age: 33),
            registered: .init(date: .now, age: 33),
            phone: "",
            cell: "",
            identifier: nil,
            picture: .init(
                large: URL(string: "http://sample.com")!,
                medium: URL(string: "http://sample.com")!,
                thumbnail: URL(string: "http://sample.com")!,
            ),
            nationality: "",
        )
    }

    public static func makeList(_ count: Int) -> [User] {
        (0..<count).map { i in .make(firstName: "User\(i)") }
    }
}
