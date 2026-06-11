//
//  UserDetailView 2.swift
//  UserDetail
//

import Foundation
import RUCUI
import SwiftUI

public struct UserDetailSwiftUIView: SwiftUI.View {
    public let model: UserDetailModel

    public var body: some SwiftUI.View {
        ScrollView {
            if let user = model.displayModel {
                VStack(spacing: 16) {
                    AvatarView(url: user.avatarURL, name: user.firstName)

                    Text("\(user.firstName) \(user.lastName)")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(user.address)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)

                    VStack(alignment: .leading) {
                        SingleRow(title: "email:", content: user.email)
                        SingleRow(title: "registration date:", content: user.registration)
                        SingleRow(title: "gender:", content: user.gender)
                    }
                    .padding()
                }
            }
        }.padding(.top, 80)
    }
}
