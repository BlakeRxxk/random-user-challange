//
//  UserView.swift
//  UsersList
//

import Foundation
import RUCUI
import SwiftUI

// MARK: - UserViewOutput

@MainActor
protocol UserViewOutput: AnyObject {
    func didTapButton(with viewModel: UserCellModel)
}

// MARK: - UserView

struct UserView: SwiftUI.View {

    // MARK: Lifecycle

    init(output: UserViewOutput? = nil, viewModel: UserCellModel) {
        self.output = output
        self.viewModel = viewModel
    }

    // MARK: Internal

    weak var output: UserViewOutput?

    var viewModel: UserCellModel

    var body: some SwiftUI.View {
        Button {
            output?.didTapButton(with: viewModel)
        } label: {
            HStack {
                ProfileRow(name: viewModel.name, subtitle: viewModel.cell, avatarURL: viewModel.avatarURL, email: viewModel.email)

                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
            }
        }
    }

}
