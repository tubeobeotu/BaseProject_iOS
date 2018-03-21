//
//  DefaultEmptyView.swift
//

import UIKit

class DefaultEmptyView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var cloudIconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //subTitleLabel.text = "Hãy thử lại".localizedString().uppercased()
        subTitleLabel.text = "".localized()
        cloudIconImage.isHidden = true
    }
}
