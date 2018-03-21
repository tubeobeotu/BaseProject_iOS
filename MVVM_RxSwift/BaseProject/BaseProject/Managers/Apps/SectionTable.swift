
import Foundation
enum SectionOfOrderDetail: SectionModelType {
    
    typealias Item = Row
    
    case header(header: String, items: [Item])
    
    enum Row {
        case header(blockTime: BlockTimeOrder, status: OrderTypes)
        case promotion(coupon: Coupon)
        case historyHeader(string: String)
        case rating(rate: Double)
        case yourOrder(orders: CategoryItem)
        case string(title: String, string: String)
        case tax(rate: String, string: String)
        case total(string: String)
        case note(note: String)
        case shipping(customer: CustomerProfile)
        case card(card: CustomerCard)
        case section(title: String)
    }
    var items: [Row] {
        switch self {
        case .header(_, let items):
            return items
        }
    }
    
    var header: String{
        switch self {
        case .header(let header, _):
            return header
        }
    }
    
    public init(original: SectionOfOrderDetail, items: [Row]) {
        switch original {
        case .header(let header, let items):
            self = .header(header: header, items: items)
        }
    }
}


