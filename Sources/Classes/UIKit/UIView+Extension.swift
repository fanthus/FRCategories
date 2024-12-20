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
    
    //  view to image
    @objc static func imageWithUIView(_ view:UIView) -> UIImage? {
        let render = UIGraphicsImageRenderer(size: view.bounds.size)
        let finalImg = render.image { context in
            view.layer.render(in: context.cgContext)
        }
        return finalImg
    }
    
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
    
    @discardableResult
    @objc static func addGradientLayerToView(_ view: UIView, startPoint:CGPoint = .init(x: 0, y: 0.5), endPoint:CGPoint = .init(x: 1, y: 0.5), colorArray colors: [Any], locations:[NSNumber] = [0,1.0], rect:CGRect = CGRectZero, relayout:Bool = false) -> CAGradientLayer {
        if relayout == true {
            view.superview?.setNeedsLayout()
            view.superview?.layoutIfNeeded()
        }
        let gl = CAGradientLayer()
        gl.frame = rect == CGRectZero ? view.bounds : rect
        gl.startPoint = startPoint
        gl.endPoint = endPoint
        gl.colors = colors;
        gl.locations = locations;
        //2024-10-31 单独对带有图片的btn做特殊处理，因为insert到0层还是会在 btn.imageView上面盖住按钮图片
        if let btn = view as? UIButton, let iv = btn.imageView {
            view.layer.insertSublayer(gl, below: iv.layer)
        } else {
            view.layer.insertSublayer(gl, at: 0)
        }
        return gl
    }
    
    @discardableResult
    @objc static func addGradientLayerToView(_ view: UIView, colorArray colors: [Any]) -> CAGradientLayer {
      return self.addGradientLayerToView(view, colorArray: colors, relayout: false)
    }
    
    @discardableResult
    @objc static func addGradientLayerToView(_ view: UIView, colorArray colors: [Any], rect: CGRect) -> CAGradientLayer {
      return self.addGradientLayerToView(view, colorArray: colors, rect: rect, relayout: true)
    }
    
    @objc static func removeGradientLayer(_ view:UIView) {
      if let sublayers = view.layer.sublayers {
        for sublayer in sublayers {
          if sublayer.isKind(of: CAGradientLayer.self) {
            sublayer.removeFromSuperlayer()
          }
        }
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
    
    //Deprecated:2024-12-11
    //基础类别中最好不要包含系统机制的实现，会干扰默认行为以及影响视图定制
//    func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        if let _ = self.touchAreaExtended, let size = self.touchSize {
//            let widthDelta = size.width - self.width
//            let heightDelta = size.height - self.height
//            let bounds = self.bounds.insetBy(dx: -0.5*widthDelta, dy: -0.5*heightDelta)
//            return bounds.contains(point)
//        } else {
//            return bounds.contains(point)
//        }
//    }
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
