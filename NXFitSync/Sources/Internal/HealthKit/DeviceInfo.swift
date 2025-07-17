//
//  DeviceInfo.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-05.
//

import Foundation

#if os(watchOS)
import WatchKit
#endif

#if os(iOS)
import UIKit
#endif

internal class DeviceInfo {
    static var Name: String? {
        #if os(watchOS)
        return WKInterfaceDevice.current().name
        #elseif os(iOS)
        return UIDevice.current.name
        #else
        return nil
        #endif
    }
    
    static var Manufacturer: String? {
        guard Name != nil else {
            return nil
        }
        
        return "Apple Inc."
    }
    
    static var OS: String? {
        #if os(watchOS)
        WKInterfaceDevice.current().systemName
        #elseif os(iOS)
        UIDevice.current.systemName
        #else
        return nil
        #endif
    }
    
    static var OSVersion: String? {
        #if os(watchOS)
        WKInterfaceDevice.current().systemVersion
        #elseif os(iOS)
        UIDevice.current.systemVersion
        #else
        return nil
        #endif
    }
}
