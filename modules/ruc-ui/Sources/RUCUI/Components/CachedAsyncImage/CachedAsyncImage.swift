//
//  CachedAsyncImage.swift
//  RUCUI
//

import SwiftUI

struct CachedAsyncImage<Content: SwiftUI.View, Placeholder: SwiftUI.View>: SwiftUI.View {

    // MARK: Lifecycle

    init(
        url: URL?,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    // MARK: Internal

    var body: some SwiftUI.View {
        Group {
            if let image = loadedImage {
                content(Image(uiImage: image))
            } else {
                placeholder()
            }
        }
        .task(id: url) {
            await load(url: url)
        }
    }

    // MARK: Private

    @State private var loadedImage: UIImage?

    private let url: URL?
    private let content: (Image) -> Content
    private let placeholder: () -> Placeholder

    private func load(url: URL?) async {
        guard let url else { return }

        if let cached = await ImageCache.shared.image(for: url) {
            loadedImage = cached
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return }
            await ImageCache.shared.insert(image, for: url)
            loadedImage = image
        } catch {
            // cancelled on scroll-off via .task cancellation — no-op
        }
    }

}
