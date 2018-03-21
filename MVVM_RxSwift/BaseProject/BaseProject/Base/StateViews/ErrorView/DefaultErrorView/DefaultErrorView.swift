//
//  DefaultErrorView.swift
//

import UIKit

class DefaultErrorView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.text = "Can't connect to server".localized()
    }
}
