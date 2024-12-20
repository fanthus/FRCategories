//
//  UIColor+Extension.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/6/24.
//

import Foundation
import UIKit

public extension UIColor {
    
    ///
    convenience init(_ hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    func hexString(_ includeAlpha: Bool = true) -> String?  {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        guard r >= 0 && r <= 1 && g >= 0 && g <= 1 && b >= 0 && b <= 1 else { return nil }
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X",
                          Int(round(r * 255)), Int(round(g * 255)),
                          Int(round(b * 255)), Int(round(a * 255)))
        } else {
            return String(format: "#%02X%02X%02X", Int(round(r * 255)),
                          Int(round(g * 255)), Int(round(b * 255)))
        }
    }
}
