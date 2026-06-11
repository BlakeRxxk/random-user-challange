//
//  SingleRow.swift
//  RUCUI
//

import SwiftUI

public struct SingleRow: SwiftUI.View {
    public init(title: String, content: String) {
        self.title = title
        self.content = content
    }

    public let title: String
    public let content: String

    public var body: some SwiftUI.View {
        HStack(alignment: .top) {
            Text(title)
            Spacer()
            Text(content)
        }
    }
}
