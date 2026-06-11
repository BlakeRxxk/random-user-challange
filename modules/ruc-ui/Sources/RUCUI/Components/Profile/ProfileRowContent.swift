//
//  ProfileRowContent.swift
//  RUCUI
//

import SwiftUI

public struct ProfileRow: SwiftUI.View {
    public init(name: String, subtitle: String? = nil, avatarImage: Image? = nil) {
        self.name = name
        self.subtitle = subtitle
        self.avatarImage = avatarImage
    }

    public var body: some SwiftUI.View {
        HStack(spacing: 16) {
            AvatarView(image: avatarImage, name: name)
            ProfileInfo(title: name, subtitle: subtitle)
        }
    }

    let name: String
    let subtitle: String?
    let avatarImage: Image?
}
