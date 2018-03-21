//
//  BaseTableViewCell.swift
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    weak var delegate: AnyObject?
    var indexPath: IndexPath?
    
    var isEnableLongPressGestureRecognizer: Bool = false
    lazy var longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isEnableLongPressGestureRecognizer {
            addGestureRecognizer(longPressGestureRecognizer)
        }
    }
    
    func setIndexPath(_ indexPath: IndexPath?, delegate: AnyObject?) {
        self.indexPath = indexPath
        self.delegate = delegate
    }
}

extension BaseTableViewCell {

    class func identifier() -> String {
        return "BaseTableViewCell"
    }
    
    func setData(_ data: Any?) {
        
    }
}

extension BaseTableViewCell {

    // MARK: - Actions
    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
    }
}
