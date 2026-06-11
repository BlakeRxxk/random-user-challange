//
//  UserDetailView.swift
//  UserDetail
//

import Foundation
import RUCUI
import UIKit

public final class UserDetailView: HostingView<UserDetailSwiftUIView> {

    // MARK: Lifecycle

    public init() {
        super.init(rootView: UserDetailSwiftUIView(model: model))
    }

    // MARK: Public

    public let model = UserDetailModel()

}
