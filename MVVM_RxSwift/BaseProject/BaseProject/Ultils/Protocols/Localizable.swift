//
//  Localizable.swift
//  AppBuilder
//
//  Created by Lucio Pham on 11/24/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

public protocol Localizable {
  func localize()
}

extension Localizable {
  
  public func localize(_ string: String?) -> String? {
    
    guard let term = string, term.hasPrefix("@") else { return string }
    
    guard !term.hasPrefix("@@") else {
      return String(term[term.index(after: term.startIndex)...])
    }
    
    return NSLocalizedString(String(term[term.index(after: term.startIndex)...]), comment: "")
  }
  
  public func localize(_ string: String?, _ setter: (String?)->()) {
    setter(localize(string))
  }
  
  public func localize(_ getter: (UIControlState) -> String?, _ setter: (String?, UIControlState)->()) {
    setter(localize(getter(.normal)), .normal)
    setter(localize(getter(.selected)), .selected)
    setter(localize(getter(.highlighted)), .highlighted)
    setter(localize(getter(.disabled)), .disabled)
  }
  
}

extension UIView: Localizable {
  @objc public func localize() {
    subviews.forEach { $0.localize() }
  }
}

public extension UILabel {
  public override func localize() {
    super.localize()
    localize(text) { text = $0 }
  }
}

public extension UIButton {
  public override func localize() {
    super.localize()
    localize(title(for:), setTitle(_:for:))
  }
}

public extension UITextField {
    public override func localize() {
        super.localize()
        localize(placeholder) { placeholder = $0 }
    }
}

extension UIViewController: Localizable {
  @objc public func localize() {
    localize(title) { title = $0 }
    view.localize()
  }
}
