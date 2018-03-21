//
//  AlertProtocol.swift
//
//
//  Created by Lucio Pham on 12/7/17.
//

import Foundation
import UIKit

protocol AlertProtocol {}

extension AlertProtocol where Self: UIViewController {
  
  func showAlertViewDefaul(_ title: String = "Warning".localized(),
                           message: String? = nil,
                           actionTitle: String = "Ok".localized()) {
    let alertViewController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
    alertViewController.addAction(okAction)
    present(alertViewController, animated: true, completion: nil)
  }
  
}

extension UIViewController: AlertProtocol {}
