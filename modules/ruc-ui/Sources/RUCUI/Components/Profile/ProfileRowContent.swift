//
//  ProfileRowContent.swift
//  RUCUI
//

import SwiftUI

public struct ProfileRow: SwiftUI.View {
    public init(name: String, subtitle: String, avatarURL: URL? = nil, email: String) {
        self.name = name
        self.subtitle = subtitle
        self.email = email
        self.avatarURL = avatarURL
    }

    public var body: some SwiftUI.View {
        HStack(spacing: 16) {
            AvatarView(url: avatarURL, name: name)
            ProfileInfo(title: name, subtitle: subtitle, email: email)
        }
    }

    let name: String
    let subtitle: String
    let avatarURL: URL?
    let email: String
}
