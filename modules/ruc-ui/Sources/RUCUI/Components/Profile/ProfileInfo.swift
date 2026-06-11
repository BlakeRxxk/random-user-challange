//
//  ProfileInfo.swift
//  RUCUI
//

import SwiftUI

struct ProfileInfo: SwiftUI.View {
    let title: String
    let subtitle: String?

    var body: some SwiftUI.View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.primary)

            if let subtitle {
                Text(subtitle)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(Color(.systemGray))
            }

            Text("mail@email.com")
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color(.systemGray))
        }
    }
}
