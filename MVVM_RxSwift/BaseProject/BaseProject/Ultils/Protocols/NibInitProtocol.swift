//
//  NibInitProtocol.swift
//  AppBuilder
//
//  Created by Lucio on 11/23/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

protocol NibLoadableView: class {}
extension UIView: NibLoadableView {}

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return String.init(describing: self)
    }
    
    static var nib: UINib {
        return UINib.init(nibName: self.nibName, bundle: nil)
    }
    
    static var identity: String {
        return String.init(describing: self) + "_IDENTITY"
    }
    
}
