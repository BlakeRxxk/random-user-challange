//
//  UserEntity+User.swift
//  RandomUserChallenge
//

import CoreData
import Foundation
import RandomUserData
import RandomUserDomain

// MARK: - Entity → Domain

extension PersistenceController {

    func map(entity: UserEntity) -> User? {
        guard
            let id = entity.id,
            let gender = Gender(rawValue: entity.gender ?? ""),
            let loginUUID = entity.loginUUID,
            let dobDate = entity.dobDate,
            let registeredDate = entity.registeredDate,
            let largePicture = entity.pictureLarge.flatMap(URL.init),
            let mediumPicture = entity.pictureMedium.flatMap(URL.init),
            let thumbnailPicture = entity.pictureThumbnail.flatMap(URL.init)
        else { return nil }

        return User(
            id: id,
            gender: gender,
            name: PersonName(
                title: entity.nameTitle ?? "",
                first: entity.nameFirst ?? "",
                last: entity.nameLast ?? "",
            ),
            location: Location(
                street: Street(
                    number: Int(entity.locationStreetNumber),
                    name: entity.locationStreetName ?? "",
                ),
                city: entity.locationCity ?? "",
                state: entity.locationState ?? "",
                country: entity.locationCountry ?? "",
                postcode: Postcode(string: entity.locationPostcode ?? ""),
                coordinates: Coordinates(
                    latitude: entity.locationLatitude,
                    longitude: entity.locationLongitude,
                ),
                timezone: Timezone(
                    offset: entity.locationTimezoneOffset ?? "",
                    description: entity.locationTimezoneDescription ?? "",
                ),
            ),
            email: entity.email ?? "",
            login: Login(
                uuid: loginUUID,
                username: entity.loginUsername ?? "",
                password: entity.loginPassword ?? "",
                salt: entity.loginSalt ?? "",
                md5: entity.loginMd5 ?? "",
                sha1: entity.loginSha1 ?? "",
                sha256: entity.loginSha256 ?? "",
            ),
            dateOfBirth: DateOfBirth(date: dobDate, age: Int(entity.dobAge)),
            registered: Registration(date: registeredDate, age: Int(entity.registeredAge)),
            phone: entity.phone ?? "",
            cell: entity.cell ?? "",
            identifier: entity.identifierName.map {
                Identifier(name: $0, value: entity.identifierValue)
            },
            picture: Picture(
                large: largePicture,
                medium: mediumPicture,
                thumbnail: thumbnailPicture,
            ),
            nationality: entity.nationality ?? "",
        )
    }

}
