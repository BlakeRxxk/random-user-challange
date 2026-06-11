//
//  Postcode.swift
//  RandomUserChallenge
//

import Foundation
import RandomUserDomain

// MARK: - Postcode helpers

extension Postcode {

    // MARK: Lifecycle

    init(string: String) {
        if let int = Int(string) {
            self = .int(int)
        } else {
            self = .string(string)
        }
    }

    // MARK: Internal

    var stringValue: String {
        switch self {
        case .int(let value): String(value)
        case .string(let value): value
        }
    }

}
