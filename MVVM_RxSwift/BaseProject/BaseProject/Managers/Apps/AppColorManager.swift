import Foundation

enum AppColor {
    case themeColor
    case negationColor
    case lightTextColor
    case intermediateTextColor
    case normalTextColor
    case greenColor
    case primaryColor
    case secondaryColor
    case highlightedColor
    case custom(hexString: String, alpha: CGFloat)
    case borderColor
    case boldDarkTextColor
    case highlightedCellColor
    case navigationTextColor
    case searchBarBG
    case darkHighLightedColor
    func withAlpha(_ alpha: CGFloat) -> UIColor {
        return self.value.withAlphaComponent(alpha)
    }
}
extension AppColor {
    
    var value: UIColor {
        switch self {
        case .primaryColor:
          guard let primaryColor = Store.currentStore?.colorPrimary else {
            return UIColor("#FEC110")
          }
          
          return UIColor("\(primaryColor)")
        case .secondaryColor:
          guard let secondaryColor = Store.currentStore?.colorSecondary else {
            return UIColor("#FE7510")
          }
            return UIColor("\(secondaryColor)")
        

        case .highlightedColor:
          return UIColor("#F2F2F2")
        case .darkHighLightedColor:
          return UIColor("#808080")
        case .custom(let hexString, let alpha):
            return UIColor(hexString).withAlphaComponent(alpha)
        case .normalTextColor:
            return UIColor.init("#828282")
        case .greenColor:
            return UIColor.init("#219653")
        case .borderColor:
            return UIColor.init("#E0E0E0")
        case .boldDarkTextColor:
            return UIColor.init("#505050")
        case .lightTextColor:
            return UIColor.init("#B7B7B7")
        case .highlightedCellColor:
            return UIColor.init("#F7F7F7")
        case .navigationTextColor:
            return UIColor.white
        case .searchBarBG:
            return UIColor.init("#F5F5F5")
        default:
            return UIColor.clear
        }
    }
    
}
