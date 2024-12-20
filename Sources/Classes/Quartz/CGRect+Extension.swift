//
//  CGRect.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/6/24.
//

import Foundation
import UIKit

public extension CGRect {
    
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
    
    init(x: CGFloat, y: CGFloat, size: CGSize) {
        self.init(x: x, y: y, width: size.width, height: size.height)
    }
    
    init(origin: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    func insetBy(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> CGRect {
        return inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }
    
    func expanded(_ amount: CGFloat, edge: CGRectEdge) -> CGRect {
        switch edge {
            case .minXEdge:
                return CGRect(x: minX - amount, y: minY, width: width + amount, height: height)
            case .maxXEdge:
                return CGRect(x: minX, y: minY, width: width + amount, height: height)
            case .minYEdge:
                return CGRect(x: minX, y: minY - amount, width: width, height: height + amount)
            case .maxYEdge:
                return CGRect(x: minX, y: minY, width: width, height: height + amount)
        }
    }
    
    func increasedHeight(by value: CGFloat) -> CGRect {
        return CGRect(x: self.origin.x, y: self.origin.y, width: self.size.width, height: self.size.height + value)
    }
    
}
