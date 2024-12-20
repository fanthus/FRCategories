//
//  CGPoint+Extension.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/6/24.
//

import Foundation

public extension CGPoint {
    
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
    
    /// point的x和y都进行ceil操作.
    /// rounded(.up) = ceil
    func ceil() -> CGPoint {
        return CGPoint.init(x: self.x.rounded(.up), y: self.y.rounded(.up))
    }
    
    /// point的x和y都进行floor操作.
    /// rounded(.down) = floor
    func floor() -> CGPoint {
        return CGPoint.init(x: self.x.rounded(.down), y: self.y.rounded(.down))
    }
}
