//
//  URL+StaticString.swift
//  RUCCore
//

import Foundation

extension URL {
    public init(staticString: StaticString) {
        // swiftlint:disable:next force_unwrapping
        self.init(string: String(describing: staticString))!
    }
}
