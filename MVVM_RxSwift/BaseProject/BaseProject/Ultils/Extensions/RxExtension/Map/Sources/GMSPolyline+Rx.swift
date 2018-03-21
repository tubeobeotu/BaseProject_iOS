//
//  GMSPolyline+Rx.swift
//  Example
//
//  Created by Gabriel Araujo on 29/10/17.
//  Copyright © 2017 Gen X Hippies Company. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import GoogleMaps

public extension Reactive where Base: GMSPolyline {
    
    public var strokeWidth: AnyObserver<CGFloat> {
        return Binder(base) { control, strokeWidth in
            control.strokeWidth = strokeWidth
        }.asObserver()
    }
    
    public var strokeColor: AnyObserver<UIColor> {
        return Binder(base) { control, strokeColor in
            control.strokeColor = strokeColor
        }.asObserver()
    }
    
}
