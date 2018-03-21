import Foundation
import ObjectMapper

class LoyaltyCoupon: Mappable
{
    var id: String?
    var name: String?
    var code: String?
    var percentage = false
    var discount: Double = 0
    var coupon_type: String?
    var loyaltyItem: LoyaltyCouponItem?
    var using_time: LoyaltyUsingTime?
    
    enum CodingKeys: String {
        case id = "id"
        case name = "name"
        case code = "code"
        case percentage = "percentage"
        case discount = "discount"
        case coupon_type = "coupon_type"
        case loyalty = "loyalty"
        case using_time = "using_time"
    }
    
    required init?(map: Map) {
        
    }
    init() {
        
    }
    func mapping(map: Map) {
        id              <- map[CodingKeys.id.rawValue]
        name            <- map[CodingKeys.name.rawValue]
        code            <- map[CodingKeys.code.rawValue]
        percentage      <- map[CodingKeys.percentage.rawValue]
        discount        <- (map[CodingKeys.discount.rawValue], DoubleTransform())
        coupon_type     <- map[CodingKeys.coupon_type.rawValue]
        loyaltyItem         <- map[CodingKeys.loyalty.rawValue]
        using_time      <- map[CodingKeys.using_time.rawValue]
    }
}

class LoyaltyCouponItem: Mappable
{
    var ticket_id: String?
    var item_id: String?
    
    enum CodingKeys: String {
        case ticket_id = "ticket_id"
        case item_id = "item_id"
    }
    
    required init?(map: Map) {
        
    }
    init() {
        
    }
    func mapping(map: Map) {
        ticket_id     <- (map[CodingKeys.ticket_id.rawValue], StringTransform())
        item_id       <- (map[CodingKeys.item_id.rawValue], StringTransform())
        
    }
}

class LoyaltyUsingTime: Mappable
{
    var start: String?
    var end: String?
    
    enum CodingKeys: String {
        case start = "start"
        case end = "end"
    }
    
    required init?(map: Map) {
        
    }
    init() {
        
    }
    func mapping(map: Map) {
        start     <- map[CodingKeys.start.rawValue]
        end       <- map[CodingKeys.end.rawValue]
    }
}

class LoyaltyReward: Mappable {
    var id: String?
    var min_price: Double?
    var items: [LoyaltyRewardItem]?
    var isCheck = false
    var step = 0
    var nextReward = -1
    var lastReward = -1
    var lastChecked = -1
    enum CodingKeys: String {
        case id = "id"
        case min_price = "min_price"
        case items = "items"
    }
    
    required init?(map: Map) {
        
    }
    init() {
        
    }
    func mapping(map: Map) {
        id              <- map[CodingKeys.id.rawValue]
        min_price       <- (map[CodingKeys.min_price.rawValue], DoubleTransform())
        items           <- map[CodingKeys.items.rawValue]
    }
    
}

class LoyaltyRewardItem: Mappable {
  
    var item_id: String?
    var used = false
    var used_date: String?
    var promotion: Coupon?
    var state: ABCouponCellState!
    var canUse = false
    enum CodingKeys: String {
        case item_id = "item_id"
        case used = "used"
        case used_date = "used_date"
        case promotion = "promotion"
    }
    
    required init?(map: Map) {
        
    }
    init() {
        
    }
    func mapping(map: Map) {
        item_id     <- (map[CodingKeys.item_id.rawValue], StringTransform())
        used        <- map[CodingKeys.used.rawValue]
        used_date   <- map[CodingKeys.used_date.rawValue]
        promotion   <- map[CodingKeys.promotion.rawValue]
        self.calculateState()
    }
    
    func calculateState()
    {
        if(self.used == true)
        {
            if(self.promotion == nil)
            {
                self.state = ABCouponCellState.Checked(value: .Normal(value: .Used))
            }
            else if(self.promotion!.used == true)
            {
                self.state =  ABCouponCellState.Checked(value: .Percent(value: .Used))
            }else
            {
                self.state = ABCouponCellState.Checked(value: .Percent(value: .UnUsed))
            }
        }else
        {
            if(self.promotion == nil)
            {
                self.state = ABCouponCellState.UnCheck
            }else
            {
                if(self.promotion!.used == false)
                {
                    self.state = ABCouponCellState.Checked(value: .Percent(value: .UnUsed))
                }else
                {
                    self.state = ABCouponCellState.Checked(value: .Percent(value: .Used))
                }
                
            }
            
        }
        
    }
}
