//
//  UserMapper.swift
//  RandomUserData
//

import Foundation
import RandomUserDomain

// MARK: - UserMapper

public enum UserMapper { }

extension UserMapper {

    public static func map(_ response: RandomUserResponseDTO) -> [User] {
        response.results.compactMap(map)
    }

}

extension UserMapper {

    public static func map(_ dto: UserDTO) -> User? {
        guard
            let loginUUID = UUID(uuidString: dto.login.uuid)
        else { return nil }

        return User(
            id: loginUUID,
            gender: mapGender(dto.gender),
            name: mapName(dto.name),
            location: mapLocation(dto.location),
            email: dto.email,
            login: mapLogin(dto.login),
            dateOfBirth: mapDOB(dto.dob),
            registered: mapRegistered(dto.registered),
            phone: dto.phone,
            cell: dto.cell,
            identifier: mapID(dto.id),
            picture: mapPicture(dto.picture),
            nationality: dto.nat,
        )
    }

}

extension UserMapper {

    fileprivate static func mapGender(_ value: String) -> Gender {
        switch value.lowercased() {
        case "male": .male
        case "female": .female
        default: .unknown
        }
    }

}

extension UserMapper {

    fileprivate static func mapName(_ dto: NameDTO) -> PersonName {
        PersonName(
            title: dto.title,
            first: dto.first,
            last: dto.last,
        )
    }

}

extension UserMapper {

    fileprivate static func mapLogin(_ dto: LoginDTO) -> Login {
        Login(
            uuid: UUID(uuidString: dto.uuid) ?? UUID(),
            username: dto.username,
            password: dto.password,
            salt: dto.salt,
            md5: dto.md5,
            sha1: dto.sha1,
            sha256: dto.sha256,
        )
    }

}

extension UserMapper {

    fileprivate static func mapDOB(_ dto: DOBDTO) -> DateOfBirth {
        DateOfBirth(
            date: parseDate(dto.date),
            age: dto.age,
        )
    }

    fileprivate static func mapRegistered(_ dto: RegisteredDTO) -> Registration {
        Registration(
            date: parseDate(dto.date),
            age: dto.age,
        )
    }

}

extension UserMapper {

    fileprivate nonisolated(unsafe) static let iso8601: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()

    fileprivate static func parseDate(_ value: String) -> Date {
        iso8601.date(from: value) ?? Date(timeIntervalSince1970: 0)
    }

}

extension UserMapper {

    fileprivate static func mapLocation(_ dto: LocationDTO) -> Location {
        Location(
            street: Street(
                number: dto.street.number,
                name: dto.street.name,
            ),
            city: dto.city,
            state: dto.state,
            country: dto.country,
            postcode: mapPostcode(dto.postcode),
            coordinates: Coordinates(
                latitude: Double(dto.coordinates.latitude) ?? 0,
                longitude: Double(dto.coordinates.longitude) ?? 0,
            ),
            timezone: Timezone(
                offset: dto.timezone.offset,
                description: dto.timezone.description,
            ),
        )
    }

}

extension UserMapper {

    fileprivate static func mapPostcode(_ dto: PostcodeDTO) -> Postcode {
        switch dto {
        case .int(let value):
            .int(value)
        case .string(let value):
            .string(value)
        }
    }

}

extension UserMapper {

    fileprivate static func mapID(_ dto: IDDTO) -> Identifier? {
        guard dto.name != nil || dto.value != nil else { return nil }

        return Identifier(
            name: dto.name,
            value: dto.value,
        )
    }

}

extension UserMapper {

    fileprivate static func mapPicture(_ dto: PictureDTO) -> Picture {
        Picture(
            large: URL(string: dto.large) ?? URL(string: "https://example.com")!,
            medium: URL(string: dto.medium) ?? URL(string: "https://example.com")!,
            thumbnail: URL(string: dto.thumbnail) ?? URL(string: "https://example.com")!,
        )
    }

}
