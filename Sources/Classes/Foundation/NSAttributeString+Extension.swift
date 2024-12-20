//
//  NSAttributeString+Extension.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/6/24.
//

import Foundation
import UIKit

public extension NSAttributedString {
  
  static func underlineAttributeString(str:String, color:UIColor, font:String, fontSize:CGFloat) -> NSAttributedString {
    let attrStr = NSAttributedString(string: str, attributes: [
      NSAttributedString.Key.underlineColor : color,
      NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
      NSAttributedString.Key.foregroundColor: color,
      NSAttributedString.Key.font:UIFont.init(name: font, size: fontSize)
    ])
    return attrStr
  }
  
  static func imageAttributedString(img:String, rect:CGRect) -> NSAttributedString {
    let img = UIImage.init(named: img)
    let attach = NSTextAttachment.init()
    attach.image = img
    attach.bounds = rect
    let attributeStr = NSMutableAttributedString.init(attachment: attach)
    return attributeStr
  }
  
  static func formatAttributedString(txt:String?,color:String, fontName:String, size:CGFloat) -> NSAttributedString {
    let font = UIFont.init(name: fontName, size: size)
    let attributes = [NSAttributedString.Key.foregroundColor : UIColor(color),NSAttributedString.Key.font:font]
    return NSAttributedString(string: txt ?? "",attributes:attributes)
  }
  
  static func attrStringFrom(text:String, font:String, size:CGFloat, color:String = "000000", bgColor:String? = nil, lineSpace:CGFloat = 0, underLine:Bool = false,underLineColor:String = "000000",strokeLine:Bool = false, strokeLineColor:String = "000000",alignment:NSTextAlignment = .left) -> NSAttributedString {
    let attr = NSAttributedString.attrFrom(text: text, font: font, size: size, color: color, bgColor: bgColor, lineSpace: lineSpace, underLine: underLine, underLineColor: underLineColor, strokeLine: strokeLine, strokeLineColor: strokeLineColor, alignment: alignment)
    let attrTxt = NSAttributedString.init(string: text, attributes: attr as [NSAttributedString.Key : Any])
    return attrTxt
  }
  
  static func attrFrom(text:String, font:String, size:CGFloat = 13,color:String = "000000", bgColor:String? = nil, lineSpace:CGFloat = 0, underLine:Bool = false,underLineColor:String = "000000", strokeLine:Bool = false, strokeLineColor:String = "000000", alignment:NSTextAlignment = .left) -> [NSAttributedString.Key : Any] {
    let paraStyle = NSMutableParagraphStyle.init()
    paraStyle.lineSpacing = lineSpace
    paraStyle.alignment = alignment
    let backColor = (bgColor != nil) ? (UIColor(bgColor ?? "ffffff")) : UIColor.clear
    var attribute:[NSAttributedString.Key: Any] = [
      .font:UIFont.init(name: font, size: size),
      .foregroundColor:UIColor(color),
      .backgroundColor:backColor,
      .paragraphStyle:paraStyle
    ]
    if underLine {
      attribute[.underlineStyle] = NSUnderlineStyle.single.rawValue
      attribute[.underlineColor] = UIColor.init(underLineColor)
    }
    if strokeLine {
      attribute[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
      attribute[.strokeColor] = UIColor(strokeLineColor)
    }
    return attribute
  }
  
  /// 给定图片名字生成图片对应'文字'
  static func attachmentFrom(imgName:String, offset:CGPoint = .zero) -> NSAttributedString {
    guard let img = UIImage.init(named: imgName) else { return NSAttributedString.init() }
    let textAttachment = NSTextAttachment.init()
    textAttachment.image = img
    textAttachment.bounds = CGRect.init(x: offset.x, y: offset.y, width: img.size.width, height: img.size.height)
    let attachmentAtr = NSAttributedString.init(attachment: textAttachment)
    return attachmentAtr
  }
  
}


public extension NSAttributedString {
  
  static func boundSizeOf(txt:String, font:String, fontSize:CGFloat = 13, lineSpace:CGFloat = 0, constrainSize:CGSize) -> CGSize {
    let attrTxt = self.attrStringFrom(text: txt, font: font, size: fontSize, lineSpace: lineSpace)
    let rect = attrTxt.boundingRect(with: constrainSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    return rect.size
  }
  
  static func boundSizeOf(attributeTxt:NSAttributedString,constrainSize:CGSize) -> CGSize {
    let rect = attributeTxt.boundingRect(with: constrainSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    return rect.size
  }
    
}
