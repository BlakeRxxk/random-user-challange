//
//  Border.swift
//  RUCUI
//

import UIKit

// MARK: - BorderType

public enum BorderType {
    case subtle

    // MARK: Internal

    var color: UIColor {
        switch self {
        case .subtle:
            .dynamicColor(light: Palette.neutral300, dark: Palette.neutral700)
        }
    }
}

// MARK: BorderType.Palette

extension BorderType {
    enum Palette {

        /// #E5E5E5
        static let neutral300 = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)

        /// #363636
        static let neutral700 = UIColor(red: 0.21, green: 0.21, blue: 0.21, alpha: 1.00)

    }
}

// MARK: - UIColor + Border

extension UIColor {
    /// Returns the associated `UIColor` for a given `BorderType`.
    ///
    /// Example usage:
    /// ```swift
    /// let color: UIColor = .border(.default)
    /// ```
    public static func border(_ type: BorderType) -> UIColor {
        type.color
    }
}
