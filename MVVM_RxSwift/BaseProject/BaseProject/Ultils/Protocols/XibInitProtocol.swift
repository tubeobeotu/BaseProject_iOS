//
//  XibInitProtocol.swift
//  AppBuilder
//
//  Created by Lucio on 11/23/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

protocol XibInstantiatable: class {}

extension UIView: XibInstantiatable {}
extension UIViewController: XibInstantiatable {}


extension XibInstantiatable where Self: UIView {
  
  static func instantiateFromXib() -> Self {
    guard
      let view = UINib(nibName: String.init(describing: Self.self), bundle: Bundle(for: Self.self)).instantiate(withOwner: nil, options: nil).first as? Self
      else { fatalError("Could not load view from nib.") }
    return view
  }
  
}

extension XibInstantiatable where Self: UIViewController {
  
  static func instantiateFromXib() -> Self {
    let nibName = String.init(describing: Self.self)
    let bundle = Bundle.init(for: Self.self)
    if let _ = bundle.path(forResource: nibName, ofType: "nib") {
      return Self.init(nibName: nibName, bundle: bundle)
    } else {
      fatalError("Could not load view controller from nib.")
    }
  }
  
}


