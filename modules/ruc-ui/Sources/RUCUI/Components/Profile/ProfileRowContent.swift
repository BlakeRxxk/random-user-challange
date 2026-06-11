//
//  ProfileRowContent.swift
//  RUCUI
//

import SwiftUI

public struct ProfileRow: SwiftUI.View {
    public init(name: String, subtitle: String? = nil, avatarURL: URL? = nil) {
        self.name = name
        self.subtitle = subtitle
        self.avatarURL = avatarURL
    }

    public var body: some SwiftUI.View {
        HStack(spacing: 16) {
            AvatarView(url: avatarURL, name: name)
            ProfileInfo(title: name, subtitle: subtitle)
        }
    }

    let name: String
    let subtitle: String?
    let avatarURL: URL?
}
