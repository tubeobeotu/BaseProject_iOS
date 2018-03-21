//
//  DevicesInfoProtocol.swift
//  AppBuilder
//
//  Created by Lucio on 11/23/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

class Ultil {}
extension Ultil: DevicesInfoProtocol {}

protocol DevicesInfoProtocol: class {
    
    static var isIphone: Bool { get }
    static var isIpad: Bool { get }
    
    static var is35InchDevice: Bool { get }
    static var is40InchDevice: Bool { get }
    static var is47InchDevice: Bool { get }
    static var is55InchDevice: Bool { get }
    static var is58InchDevice: Bool { get }
    
    static var deviceScreenSize: CGRect { get }
    
    static var screenWidth: CGFloat { get }
    static var screenHeight: CGFloat { get }
    
    static var deviceID: String { get }
    static var deviceName: String { get }
    
    static var systemVersion: String { get }
    
    static var navigationBarHeight: CGFloat { get }
    
}

extension DevicesInfoProtocol {
    
    static var isIphone: Bool { return UIDevice.current.userInterfaceIdiom == .phone }
    static var isIpad: Bool { return UIDevice.current.userInterfaceIdiom == .pad }
    
    static var deviceScreenSize: CGRect { return UIScreen.main.bounds }
    
    static var screenWidth: CGFloat { return UIScreen.main.bounds.size.width }
    static var screenHeight: CGFloat { return  UIScreen.main.bounds.size.height }
    
    static var deviceID: String { return UIDevice.current.identifierForVendor!.uuidString }
    static var deviceName: String { return UIDevice.current.systemName }
    
    static var systemVersion: String { return UIDevice.current.systemVersion }
    
    static var is35InchDevice: Bool {
        return UIScreen.main.bounds.size.height == 480
    }
    
    static var is40InchDevice: Bool {
        return UIScreen.main.bounds.size.height == 568
    }
    
    static var is47InchDevice: Bool {
        return UIScreen.main.bounds.size.width == 375
    }
    
    static var is55InchDevice: Bool {
        return UIScreen.main.bounds.size.width == 414
    }
    
    static var is58InchDevice: Bool {
        return UIScreen.main.bounds.size.height == 812
    }
    
    static var navigationBarHeight: CGFloat{
        return 64.0
    }
}
