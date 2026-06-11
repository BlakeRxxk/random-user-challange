//
//  AvatarView.swift
//  RUCUI
//

import SwiftUI

// MARK: - AvatarView

public struct AvatarView: SwiftUI.View {

    // MARK: Lifecycle

    public init(url: URL? = nil, name: String) {
        self.url = url
        self.name = name
    }

    // MARK: Public

    public var body: some SwiftUI.View {
        CachedAsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            placeholder
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }

    public var placeholder: some SwiftUI.View {
        PlaceholderView(name: name)
    }

    // MARK: Internal

    let url: URL?

    let name: String

    // MARK: Private

    private let size: CGFloat = 56

}
