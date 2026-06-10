//
//  Localize.swift
//  RUCCore
//

import Foundation

extension String {
    /// Returns a localized version of the string.
    public func localize(tableName: String? = nil, bundle: Bundle = .main, comment: String = "") -> String {
        NSLocalizedString(
            self,
            tableName: tableName,
            bundle: bundle,
            value: "",
            comment: comment,
        )
    }
}
