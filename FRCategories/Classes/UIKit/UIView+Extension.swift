//
//  UIView+Extension.swift
//  ParadotAI
//
//  Created by fanthus on 2024/6/24.
//

import Foundation
import UIKit


public extension UIView {
    
    var size:CGSize { return self.bounds.size }
    
    var left:CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin = .init(x: newValue, y: self.frame.origin.y) }
    }
    
    var top:CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin = .init(x: self.frame.origin.x, y: newValue) }
    }
    
    var right:CGFloat {
        get { return self.frame.origin.x + self.frame.size.width }
        set { self.frame.origin = .init(x: newValue - self.frame.size.width, y: self.frame.origin.y) }
    }
    
    var bottom:CGFloat {
        get { return self.frame.origin.y + self.frame.size.height}
        set { self.frame.origin = .init(x: self.frame.origin.x, y: newValue - self.frame.size.height)}
    }
    
    var width:CGFloat { return self.frame.size.width }
    
    var height:CGFloat { return self.frame.size.height }
    
    var leftTop:CGPoint { return self.frame.origin }
    
    var leftCenter:CGPoint { return CGPoint(x: self.frame.origin.x, y: self.frame.origin.y + self.height/2) }
    
    var bottomLeft:CGPoint { return CGPoint(x: self.frame.origin.x, y: self.frame.origin.y + self.height) }
    
    var bottomCenter:CGPoint { return CGPoint(x: self.frame.origin.x + self.width/2, y: self.frame.origin.y + self.height) }
    
    var bottomRight:CGPoint { return CGPoint(x: self.frame.origin.x + self.width, y: self.frame.origin.y + self.height) }
    
    var rightCenter:CGPoint { return CGPoint(x: self.frame.origin.x + self.width, y: self.frame.origin.y + self.height/2) }
    
    var rightTop:CGPoint { return CGPoint(x: self.frame.origin.x + self.width, y: self.frame.origin.y) }
    
    var topCenter:CGPoint { return CGPoint(x: self.frame.origin.x + self.width/2, y: self.frame.origin.y) }
    
}

public extension UIView {
    
    //  view to image
    @objc static func imageWithUIView(_ view:UIView) -> UIImage? {
        let render = UIGraphicsImageRenderer(size: view.bounds.size)
        let finalImg = render.image { context in
            view.layer.render(in: context.cgContext)
        }
        return finalImg
    }
    
}

public extension UIView {
    
    @objc func hideWithAnimation(_ duration:TimeInterval=0.2) {
        self.alpha = 1
        UIView.animate(withDuration: duration) { [weak self] in
            guard let wself = self else { return }
            wself.alpha = 0
        } completion: { [weak self] _ in
            guard let wself = self else { return }
            wself.isHidden = true
        }
    }
    
    @objc func unhideWithAnimation(_ duration:TimeInterval=0.2) {
        self.isHidden = false
        self.alpha = 0
        UIView.animate(withDuration: duration) { [weak self] in
            guard let wself = self else { return }
            wself.alpha = 1
        } completion: {[weak self]  _ in
            guard let wself = self else { return }
            wself.isHidden = false
        }
    }
    
}

public extension UIView {
    static var _TouchSizeKey = "UIView._TouchSizeKey"
    static var _TouchAreaExtendedKey = "UIView._TouchAreaExtendedKey"
    
    var touchSize:CGSize? {
        get {
            if let tscore = objc_getAssociatedObject(self, &UIView._TouchSizeKey) as? CGSize { return tscore }
            return nil
        }
        set { objc_setAssociatedObject(self, &UIView._TouchSizeKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    var touchAreaExtended:Bool? {
        get {
            if let touchAreaExtendedVal = objc_getAssociatedObject(self, &UIView._TouchAreaExtendedKey) as? Bool { return touchAreaExtendedVal }
            return nil
        }
        set { objc_setAssociatedObject(self, &UIView._TouchAreaExtendedKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let _ = self.touchAreaExtended, let size = self.touchSize {
            let widthDelta = size.width - self.width
            let heightDelta = size.height - self.height
            let bounds = self.bounds.insetBy(dx: -0.5*widthDelta, dy: -0.5*heightDelta)
            return bounds.contains(point)
        } else {
            return bounds.contains(point)
        }
    }
}


public extension UIView {
    
    @objc func setCustomCornerRadius(_ value: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    @objc func setCustomCornerRadius(_ value: CGFloat, corner mask: CACornerMask) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = mask
    }
        
}
