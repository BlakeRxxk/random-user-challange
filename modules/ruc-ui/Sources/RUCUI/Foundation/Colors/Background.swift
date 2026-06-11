//
//  Background.swift
//  RUCUI
//

import UIKit

// MARK: - BackgroundType

public enum BackgroundType {
    case primary
    case secondary

    case avatar

    // MARK: Internal

    var color: UIColor {
        switch self {
        case .primary:
            .dynamicColor(light: Palette.neutral100, dark: Palette.neutral900)

        case .secondary:
            .dynamicColor(light: Palette.neutral200, dark: Palette.neutral800)

        case .avatar:
            Palette.kiwi400
        }
    }
}

// MARK: BackgroundType.Palette

extension BackgroundType {
    enum Palette {

        /// #FFFFFF
        static let neutral100 = UIColor.white
        /// #F7F7F7
        static let neutral200 = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)

        /// #FFFFFF
        static let neutral900 = UIColor.black
        /// #191919
        static let neutral800 = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)

        /// ##4CE160
        static let kiwi400 = UIColor(red: 0.30, green: 0.88, blue: 0.38, alpha: 1.00)

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
