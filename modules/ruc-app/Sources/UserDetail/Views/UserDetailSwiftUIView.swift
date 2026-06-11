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
                AvatarView(url: user.avatarURL, name: user.firstName)
                HStack {
                    Text("\(user.firstName) \(user.lastName)")
                }
                HStack {
                    Text(user.address).multilineTextAlignment(.center)
                }
                VStack(alignment: .leading) {
                    SingleRow(title: "email:", content: user.email)
                    SingleRow(title: "registration date:", content: user.registration)
                    SingleRow(title: "gender:", content: user.gender)
                }.padding()
            }
        }.padding(.top, 80)
    }
}
