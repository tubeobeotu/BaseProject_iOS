import UIKit
import Foundation


struct Constant {
	static let SCREEN_WIDTH_PORTRAIT = UIScreen.main.bounds.size.width
	static let SCREEN_HEIGHT_PORTRAIT = UIScreen.main.bounds.size.height
	static let NUMBER_RECORDS_PER_PAGE = 10
}

extension Constant {
    
    // MARK: - App Delegate
    static func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
	
	// MARK: - Notification Key
	struct notificationKey {
		static let DID_UPDATE_STATION_NOTIFICATION_KEY: String = "DID_UPDATE_STATION_NOTIFICATION_KEY"
	}

    // MARK: - View
    struct view {
        static var window: UIView {
            get {
                return UIApplication.shared.keyWindow!
            }
        }
    }
    
    // MARK: - App Information
    struct appInformation {
        static var version: String {
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                return version
            }
            
            return "alpha"
        }
    }
    
    // MARK: - Colors
    struct color {
        static var blueVSmart: UIColor {
            return UIColor.colorWithHexString("#0488D1")
        }
        
        static var backgroundVSmart: UIColor {
            return UIColor.colorWithHexString("#f9f9f9")
        }
        
        static var textVSmart: UIColor {
            return UIColor.colorWithHexString("#757575")
        }
        
        static var textColorVSmart: UIColor {
            return UIColor.colorWithHexString("#000000")
        }
        
        static var greenVSmart: UIColor
        {
            return UIColor.colorWithHexString("#49A28C")
        }
    }
	
	// MARK: - Format Date
	struct formatDate {
		static var shortNormalFormat: String{
			return "dd/MM/yyyy"
		}
		static let fulNormalFormat: String = "dd/MM/yyy HH:mm:ss" //"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let fulHourFormat: String = "HH:mm:ss"
	}
    
    // MARK: - Fonts
    struct font {
        static func robotoBlack(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-Black", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoBlackItalic(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-BlackItalic", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoBold(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-Bold", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoBoldItalic(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-BoldItalic", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoItalic(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-Italic", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoLight(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-Light", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoLightItalic(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-LightItalic", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoMedium(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-Medium", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoMediumItalic(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-MediumItalic", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoRegular(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-Regular", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoThin(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-Thin", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoThinItalic(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-ThinItalic", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoCondensedBold(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-CondensedBold", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoCondensedBoldItalic(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-CondensedBoldItalic", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoCondensedItalic(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-CondensedItalic", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoCondensedLight(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-CondensedLight", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoCondensedLightItalic(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-CondensedLightItalic", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
        
        static func robotoCondensedRegular(ofSize fontSize: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Roboto-CondensedRegular", size: fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            
            return font
        }
    }
	
	//Platform
	struct Platform {
		static let isSimulator: Bool = {
			var isSim = false
			#if arch(i386) || arch(x86_64)
				isSim = true
			#endif
			return isSim
		}()
	}
}
