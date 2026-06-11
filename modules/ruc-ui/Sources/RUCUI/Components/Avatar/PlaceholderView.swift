//
//  PlaceholderView.swift
//  RUCUI
//

import SwiftUI

public struct PlaceholderView: SwiftUI.View {
    public init(name: String) {
        fallbackLetter = String(name.prefix(1)).uppercased()
    }

    public var body: some SwiftUI.View {
        Circle()
            .fill(
                Color(uiColor: .background(.avatar))
            )
            .overlay(
                Text(fallbackLetter)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(uiColor: .foreground(.avatar)))
            )
    }

    let fallbackLetter: String
}
