//
//  UIDevice+Extension.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/5/24.
//

import Foundation
import UIKit

public extension UIDevice {
    
    static var modelIdentifier: String? {
        var systemInfo = utsname()
        uname(&systemInfo)
        let identifier = withUnsafePointer(to: &systemInfo.machine, {
            $0.withMemoryRebound(to: CChar.self, capacity: Int(_SYS_NAMELEN)) {
                ptr in String(cString: ptr)
            }
        })
        // Simulator Check
        if identifier == "x86_64" || identifier == "i386" || identifier == "arm64" {
            return ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"]
        }
        return identifier
    }
    
    static let idfvStr:String? = {
        return UIDevice.current.identifierForVendor?.uuidString
    }()
    
    static let osVerStr:String = {
        return UIDevice.current.systemVersion
    }()
    
    static let is320Width: Bool = {
        let shortSide = min(UIScreen.main.bounds.size.width,
                            UIScreen.main.bounds.size.height)
        return shortSide == 320
    }()
    
    
}
