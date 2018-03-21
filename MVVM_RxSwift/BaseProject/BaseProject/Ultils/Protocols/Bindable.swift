//
//  Bindable.swift
//  AB Branded App
//
//  Created by Lucio Pham on 12/15/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation
import Reachability

protocol Bindable {
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  
  func bindViewModel()
  
}

extension Bindable where Self: UIViewController {
  
  mutating func bindViewModel(to model: Self.ViewModelType) {
    viewModel = model
    loadViewIfNeeded()
    bindViewModel()
  }
  
}

