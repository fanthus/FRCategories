//
//  UIScrollView+Extension.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/3/24.
//

import UIKit

public extension UIScrollView {
    
    func scrollToTopAnimated(animated:Bool) {
        var off = self.contentOffset
        off.y = 0 - self.contentInset.top
        self.setContentOffset(off, animated: animated)
    }
    
    
    func scrollToBottomAnimated(animated:Bool) {
        var off = self.contentOffset
        off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom
        self.setContentOffset(off, animated: animated)
    }
    
}
