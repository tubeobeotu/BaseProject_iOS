//
//  BaseCollectionViewCell.swift
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: AnyObject?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setIndexPath(_ indexPath: IndexPath?, delegate: AnyObject?) {
        self.indexPath = indexPath
        self.delegate = delegate
    }
}

extension BaseCollectionViewCell {
    
    class func identifier() -> String {
        return "BaseCollectionViewCell"
    }
    
    func setData(_ data: Any?) {
        
    }
}
