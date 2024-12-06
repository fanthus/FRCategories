//
//  UIButton+Extension.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/6/24.
//

import Foundation
import UIKit


extension UIButton {
    
    @objc func enable() {
        self.isEnabled = true
        self.alpha = 1
    }
    
    @objc func disable(with alpha:CGFloat = 0.8) {
        self.isEnabled = false
        self.alpha = alpha
    }
    
}

private var gradientlayerKey: UInt8 = 0
extension UIButton {
    
    @objc func enableWithGradient(startColor:UIColor, endColor:UIColor) {
        var layer = objc_getAssociatedObject(self, &gradientlayerKey) as? CALayer
        layer?.removeFromSuperlayer()
        layer = nil
        layer = UIView.addGradientLayerToView(self, startPoint: .init(x: 0, y: 0.5), endPoint: .init(x: 1, y: 0.5), colorArray: [startColor.cgColor,endColor.cgColor], locations: [0,1])
        objc_setAssociatedObject(self, &gradientlayerKey, layer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.isEnabled = true
    }
    
    @objc func disableWithGradient(startColor:UIColor, endColor:UIColor) {
        var layer = objc_getAssociatedObject(self, &gradientlayerKey) as? CALayer
        layer?.removeFromSuperlayer()
        layer = nil
        layer = UIView.addGradientLayerToView(self, startPoint: .init(x: 0, y: 0.5), endPoint: .init(x: 1, y: 0.5), colorArray: [startColor.cgColor, endColor.cgColor], locations: [0,1])
        objc_setAssociatedObject(self, &gradientlayerKey, layer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.isEnabled = false
    }
    
}
