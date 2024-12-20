//
//  String+Extension.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/6/24.
//

import Foundation

/// REF:
///     https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SwiftStdlib/StringExtensions.swift
///     https://github.com/ibireme/YYCategories/blob/master/YYCategories/Foundation/NSString%2BYYAdd.h
public extension String {
    
    static func isNilOrEmpty(_ str:NSString?) -> Bool {
      if str == nil || str?.length == 0 {
        return true
      }
      return false
    }
    
    /// 得到一组重复拼接的字符串
    func repeatString(_ count: Int) -> String {
        guard count > 0 else { return self }
        var str = ""
        for _ in 0..<count {
            str.append(self)
        }
        return str
    }
    
    var firstCharacterAsString: String? {
        guard let first else { return nil }
        return String(first)
    }
    
    func toNumber(_ locale:Locale? = nil) -> NSNumber? {
        let formatter = NumberFormatter()
        formatter.locale = locale ?? Locale(identifier: "zh-CN")
        return formatter.number(from: self)
    }
    
    func toDouble(_ locale:Locale? = nil) -> Double? {
        return self.toNumber()?.doubleValue
    }
    
    func toInt(_ locale:Locale? = nil)->Int? {
        return self.toNumber()?.intValue
    }
    
    func toInt64(_ locale:Locale? = nil)->Int64? {
        return self.toNumber()?.int64Value
    }
    
    func trimBlanks()->String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// base64解码
    func string(with base64EncodedString:String) -> String? {
        guard let data = Data(base64Encoded: base64EncodedString) else { return nil }
        return String.init(data: data, encoding: .utf8)
    }
    
    /// base64编码
    func base64EncodedString() -> String? {
        return self.data(using: .utf8)?.base64EncodedString() ?? nil
    }
    
    /// 是否为空串
    var isNotBlank: Bool {
        let blankCharacterSet = CharacterSet.whitespacesAndNewlines
        return self.unicodeScalars.contains { !blankCharacterSet.contains($0) }
    }
    
    /// 包含其他字符串
    func containsString(_ string: String?) -> Bool {
        guard let string = string else { return false }
        return self.range(of: string) != nil
    }
    
    /// 包含指定字符集
    func containsCharacterSet(_ set: CharacterSet?) -> Bool {
        guard let set = set else { return false }
        return self.rangeOfCharacter(from: set) != nil
    }
    
    /// URL编码
    public func urlEncode() -> String? {
        self.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) ?? nil
    }
    
    func toJsonObject() -> Any? {
        if let data = self.data(using: .utf8) {
            if let obj = try? JSONSerialization.jsonObject(with: data, options: []) {
                return obj
            }
        }
        return nil
    }
    
}
