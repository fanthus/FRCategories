//
//  UIScreen.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/6/24.
//

import Foundation
import UIKit

public extension UIScreen {
    
    static var _screenScale:CGFloat?
    
    static let screenWidth:CGFloat = UIScreen.main.bounds.width
    static let screenHeight:CGFloat = UIScreen.main.bounds.height
    
    var screenScale:CGFloat {
        if let scale = UIScreen._screenScale {
            return scale
        } else {
            UIScreen._screenScale = UIScreen.main.scale
            return UIScreen._screenScale!
        }
    }
    
    func bounds(for orientation:UIInterfaceOrientation = .portrait) -> CGRect {
        var bounds = self.bounds
        if orientation.isLandscape {
            let t = bounds.size.width
            bounds.size.width = bounds.size.height
            bounds.size.height = t
        }
        return bounds
    }
}
