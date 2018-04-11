
import UIKit

@IBDesignable class VTView: UIView {

	@IBInspectable public var cornerRadius: CGFloat = 0.0 {
		didSet {
			layer.cornerRadius = cornerRadius
			layer.masksToBounds = true
		}
	}
    
	@IBInspectable public var borderWidth: CGFloat = 1.0 {
		didSet {
			layer.borderWidth = borderWidth
		}
	}
	
	@IBInspectable public var borderColor: UIColor = .white {
		didSet {
			layer.borderColor = borderColor.cgColor
		}
	}
}
