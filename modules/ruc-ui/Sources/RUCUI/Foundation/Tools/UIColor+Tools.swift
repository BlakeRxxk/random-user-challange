//
//  UIColor+Tools.swift
//  RUCUI
//

import UIKit

extension UIColor {

    public class func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        UIColor { (traits: UITraitCollection) -> UIColor in
            switch traits.userInterfaceStyle {
            case .dark:
                return dark
            case .light,
                 .unspecified:
                return light
            @unknown default:
                return light
            }
        }
    }

}
