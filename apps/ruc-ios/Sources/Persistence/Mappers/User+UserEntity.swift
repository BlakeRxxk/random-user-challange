//
//  User+UserEntity.swift
//  RandomUserChallenge
//

import CoreData
import Foundation
import RandomUserData
import RandomUserDomain

// MARK: - Domain → Entity

extension PersistenceController {

    func map(user: User, to entity: UserEntity) {
        entity.id = user.id
        entity.gender = user.gender.rawValue
        entity.nameTitle = user.name.title
        entity.nameFirst = user.name.first
        entity.nameLast = user.name.last
        entity.email = user.email
        entity.phone = user.phone
        entity.cell = user.cell
        entity.nationality = user.nationality

        entity.loginUUID = user.login.uuid
        entity.loginUsername = user.login.username
        entity.loginPassword = user.login.password
        entity.loginSalt = user.login.salt
        entity.loginMd5 = user.login.md5
        entity.loginSha1 = user.login.sha1
        entity.loginSha256 = user.login.sha256

        entity.dobDate = user.dateOfBirth.date
        entity.dobAge = Int32(user.dateOfBirth.age)

        entity.registeredDate = user.registered.date
        entity.registeredAge = Int32(user.registered.age)

        entity.pictureLarge = user.picture.large.absoluteString
        entity.pictureMedium = user.picture.medium.absoluteString
        entity.pictureThumbnail = user.picture.thumbnail.absoluteString

        entity.locationCity = user.location.city
        entity.locationState = user.location.state
        entity.locationCountry = user.location.country
        entity.locationPostcode = user.location.postcode.stringValue
        entity.locationStreetName = user.location.street.name
        entity.locationStreetNumber = Int32(user.location.street.number)
        entity.locationLatitude = user.location.coordinates.latitude
        entity.locationLongitude = user.location.coordinates.longitude
        entity.locationTimezoneOffset = user.location.timezone.offset
        entity.locationTimezoneDescription = user.location.timezone.description

        entity.identifierName = user.identifier?.name
        entity.identifierValue = user.identifier?.value
    }

}
