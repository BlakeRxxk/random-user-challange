//
//  AvatarView.swift
//  RUCUI
//

import SwiftUI

public struct AvatarView: SwiftUI.View {

    // MARK: Lifecycle

    public init(image: Image? = nil, name: String) {
        self.image = image
        self.name = name
    }

    // MARK: Public

    public var body: some SwiftUI.View {
        Group {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                PlaceholderView(name: name)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }

    // MARK: Internal

    let image: Image?
    let name: String

    // MARK: Private

    private let size: CGFloat = 56

}
