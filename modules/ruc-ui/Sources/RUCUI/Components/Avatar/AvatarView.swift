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
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                placeholder
                    .overlay(shimmerOverlay)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure:
                placeholder

            @unknown default:
                placeholder
            }
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

    private var shimmerOverlay: some SwiftUI.View {
        Circle()
            .fill(Color.white.opacity(0.25))
            .modifier(ShimmerModifier())
    }

}

// MARK: - ShimmerModifier

private struct ShimmerModifier: ViewModifier {
    func body(content: Content) -> some SwiftUI.View {
        content
            .opacity(pulsing ? 0.0 : 0.4)
            .animation(
                .easeInOut(duration: 0.9).repeatForever(autoreverses: true),
                value: pulsing,
            )
            .onAppear { pulsing = true }
    }

    @State private var pulsing = false
}
