
import Foundation

enum AppFont {
  
  fileprivate struct FontName {
    static let montserratRegular = "Montserrat-Regular"
    static let montserratMedium  = "Montserrat-Medium"
    static let montserratSemiBold = "Montserrat-SemiBold"
    static let montserratBold = "Montserrat-Bold"
    static let montserratThin = ""
    static let montserratLight = "Montserrat-Light"
  }
  
  case regular(fontSize: CGFloat)
  case medium(fontSize: CGFloat)
  case semiBold(fontSize: CGFloat)
  case bold(fontSize: CGFloat)
  case thin(fontSize: CGFloat)
  case light(fontSize: CGFloat)
  
  var font: UIFont {
    switch self {
    case .regular(let size):
      return UIFont(name: FontName.montserratRegular, size: size) ?? UIFont.systemFont(ofSize: size)
    case .medium(let size):
      return UIFont(name: FontName.montserratMedium, size: size) ?? UIFont.systemFont(ofSize: size)
    case .semiBold(let size):
      return UIFont(name: FontName.montserratSemiBold, size: size) ?? UIFont.systemFont(ofSize: size)
    case .bold(let size):
      return UIFont(name: FontName.montserratSemiBold, size: size) ?? UIFont.systemFont(ofSize: size)
    case .thin(let size):
      return UIFont(name: FontName.montserratThin, size: size) ?? UIFont.systemFont(ofSize: size)
    case .light(let size):
      return UIFont(name: FontName.montserratLight, size: size) ?? UIFont.systemFont(ofSize: size)
    }
  }
}
