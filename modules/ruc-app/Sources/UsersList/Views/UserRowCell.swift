//
//  UserRowCell.swift
//  UsersList
//

import Foundation
import RUCUI
import SwiftUI
import UIKit

// MARK: - UserRowCellOutput

protocol UserRowCellOutput: UserViewOutput { }

// MARK: - UserRowCell

final class UserRowCell: UICollectionViewCell {

    static let reuseIdentifier = "UserRowCellID"

    weak var output: UserRowCellOutput?

    override func prepareForReuse() {
        super.prepareForReuse()

        contentConfiguration = nil
    }

    func configure(with viewModel: UserCellModel) {
        contentConfiguration = UIHostingConfiguration {
            UserView(output: self, viewModel: viewModel)
        }
        contentView.backgroundColor = .background(.primary)
    }

}

// MARK: UserViewOutput

extension UserRowCell: UserViewOutput {
    func didTapButton(with viewModel: UserCellModel) {
        output?.didTapButton(with: viewModel)
    }
}
