//
//  UIColor+Tools.swift
//  ruc-ui
//
//  Created by Oleg Kurgaev on 11.06.26.
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
