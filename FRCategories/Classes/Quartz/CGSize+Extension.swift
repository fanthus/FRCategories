//
//  CGSize+Extension.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/6/24.
//

import Foundation


public extension CGSize {
    
    func insetBy(dx: CGFloat, dy: CGFloat) -> CGSize {
        return CGSize(width: width - dx * 2, height: height - dy * 2)
    }
    
    var rect: CGRect {
        return CGRect(origin: .zero, size: self)
    }
    
    func with(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: self.height)
    }
    
    func with(height: CGFloat) -> CGSize {
        return CGSize(width: self.width, height: height)
    }
    
    func rect(with origin: CGPoint) -> CGRect {
        return CGRect(origin: origin, size: self)
    }
    
    func increaseHeight(_ value: CGFloat) -> CGSize {
        return CGSize(width: width, height: height + value)
    }
    
    func increaseWidth(_ value: CGFloat) -> CGSize {
        return CGSize(width: width + value, height: height)
    }
    
    func centered(in rect: CGRect) -> CGRect {
        let centeredPoint = CGPoint(x: rect.minX + (rect.width - width) / 2, y: rect.minY + (rect.height - height) / 2)
        let point = CGPoint(x: centeredPoint.x, y: centeredPoint.y)
        return CGRect(origin: point, size: self)
    }
    
    
    /// size的width和height都进行ceil操作.
    /// rounded(.up) = ceil
    func ceil() -> CGSize {
        return CGSize.init(width: self.width.rounded(.up), height: self.height.rounded(.up))
    }
    
    /// size的width和height都进行floor操作.
    /// rounded(.down) = floor
    func floor() -> CGSize {
        return CGSize.init(width: self.width.rounded(.down), height: self.height.rounded(.down))
    }
    
    
}
