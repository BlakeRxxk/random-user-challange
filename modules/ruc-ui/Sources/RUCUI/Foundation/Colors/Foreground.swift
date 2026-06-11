//
//  Foreground.swift
//  RUCUI
//

import UIKit

// MARK: - ForegroundType

public enum ForegroundType {
    case avatar
    case refreshControl

    // MARK: Internal

    var color: UIColor {
        switch self {
        case .avatar:
            Palette.kiwi700
        case .refreshControl:
            Palette.kiwi700
        }
    }
}

// MARK: ForegroundType.Palette

extension ForegroundType {
    enum Palette {

        /// #1B561A
        static let kiwi700 = UIColor(red: 0.11, green: 0.34, blue: 0.10, alpha: 1.00)

    }
}

// MARK: - UIColor + Foreground

extension UIColor {
    /// Returns the associated `UIColor` for a given `ForegroundType`.
    ///
    /// Example usage:
    /// ```swift
    /// let color: UIColor = .foreground(.default)
    /// ```
    public static func foreground(_ type: ForegroundType) -> UIColor {
        type.color
    }
}
