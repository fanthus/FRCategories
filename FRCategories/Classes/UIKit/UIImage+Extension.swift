//
//  UIImage+Extension.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/5/24.
//

import Foundation
import UIKit

public extension UIImage {
    
    @objc func isSquare() -> Bool {
        if self.size.width == self.size.height {
            return true
        }
        return false
    }
    
    @objc static func imageWithColor(_ color:UIColor) -> UIImage {
        let rect:CGRect = .init(x: 0, y: 0, width: 1, height: 1)
        let render = UIGraphicsImageRenderer(size: rect.size)
        let colorImg = render.image { context in
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.fill([rect])
        }
        return colorImg
    }
    
    @objc static func createImage(from view: UIView) -> UIImage? {
        let render = UIGraphicsImageRenderer(size: view.bounds.size)
        let finalImg = render.image { context in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        }
        return finalImg
    }
    
    @objc static func tailoringImage(_ img: UIImage?, area: CGRect, scale: CGFloat) -> UIImage? {
        guard let sourceImageRef = img?.cgImage else { return nil }
        let rect = CGRect(x: area.origin.x * scale, y: area.origin.y * scale, width: area.size.width * scale, height: area.size.height * scale)
        guard let newImageRef = sourceImageRef.cropping(to: rect) else { return nil }
        let newImage = UIImage(cgImage: newImageRef)
        return newImage
    }
    
    @objc static func imageCompressWithSimple(_ image: UIImage?, scaledToSize size: CGSize, scale: CGFloat) -> UIImage? {
        guard let image = image else { return nil }
        let intSize = CGSizeMake(floor(size.width), floor(size.height))
        let render = UIGraphicsImageRenderer(size: intSize)
        let scaledImage = render.image { context in
            image.draw(in: CGRect(origin: .zero, size: intSize))
        }
        return scaledImage
    }
    
    // generate image use gradient layer
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// UIImage->base64 String
    func toBase64() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 1) else { return nil }
        let strBase64 = imageData.base64EncodedString()
        return strBase64
    }
    
    /// base64 String->UIImage
    convenience init(base64Str: String) {
        guard let imageData = Data(base64Encoded: base64Str) else {
            self.init()
            return
        }
        self.init(data: imageData)!
    }
}
