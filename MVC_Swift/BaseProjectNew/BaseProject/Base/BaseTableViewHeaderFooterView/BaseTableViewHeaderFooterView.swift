//
//  BaseTableViewHeaderFooterView.swift
//

import UIKit

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {

    weak var delegate: AnyObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension BaseTableViewHeaderFooterView {

    class func identifier() -> String {
        return "BaseTableViewHeaderFooterView"
    }
    
    func setData(_ data: Any?) {
        
    }
}
