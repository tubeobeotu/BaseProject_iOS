import Foundation
import UIKit

extension UIButton {
    
	func isEnableCustom(enable: Bool) {
		isEnabled = enable
		if enable {
			self.alpha = 1.0
		} else {
			self.alpha = 0.3
		}
	}
}

class UpperTitleButton: UIButton
{
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title?.uppercased(), for: state)
    }
}

extension UIButton {
	func underline() {
		guard let text = self.titleLabel?.text else { return }
		let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, text.characters.count))
		self.setAttributedTitle(titleString, for: .normal)
	}
}
