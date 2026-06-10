//
//  Background.swift
//  RUCUI
//

import UIKit

// MARK: - BackgroundType

public enum BackgroundType {
    case primary

    // MARK: Internal

    var color: UIColor {
        switch self {
        case .primary:
            Palette.white
        }
    }
}

// MARK: BackgroundType.Palette

extension BackgroundType {
    enum Palette {

        /// #FFFFFF
        static let white = UIColor.white

    }
}

// MARK: - UIColor + Background

extension UIColor {
    /// Returns the associated `UIColor` for a given `BackgroundType`.
    ///
    /// Example usage:
    /// ```swift
    /// let color: UIColor = .background(.default)
    /// ```
    public static func background(_ type: BackgroundType) -> UIColor {
        type.color
    }
}
