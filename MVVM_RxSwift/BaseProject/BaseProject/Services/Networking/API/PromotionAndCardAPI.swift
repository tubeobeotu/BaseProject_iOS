
import Foundation
enum PromotionAndCardAPI {
    case verifyPromoion(code: String)
    case getListPromotion()
    case getListCardAndPromotions()
    case addPromotion(promotion: Dictionary<String, Any>)
    case deletePromotion(promotionId: String)
    case updatePromotionAndCard(promotions: [Dictionary<String, Any>], cards: [Dictionary<String, Any>])
    
    case addCard(cardToken: String)
    case removeCard(cardId: String)
}

extension PromotionAndCardAPI: TargetType {
    
    var path: String {
        switch(self)
        {
        case .verifyPromoion(let code):
            return PromotionAndCardEndPoint.verifyPromotion + code
        case .getListPromotion():
            return PromotionAndCardEndPoint.listPromotion
        case .getListCardAndPromotions():
            return PromotionAndCardEndPoint.listCardAndPromotions
        case .addPromotion(_):
            return PromotionAndCardEndPoint.addPromotion
        case .deletePromotion(let promotionId):
            return PromotionAndCardEndPoint.deletePromotion + promotionId
        case .updatePromotionAndCard(_, _):
            return PromotionAndCardEndPoint.updatePromotionAndCard
        case .addCard(_):
            return PromotionAndCardEndPoint.addCard
        case .removeCard(let cardId):
            return PromotionAndCardEndPoint.removeCard + cardId            
        }
    }
    var method: Moya.Method {
        switch(self)
        {
        
        case .addPromotion(_):
            return .post
        case .addCard(_):
            return .post
        case .deletePromotion(_):
            return .delete
        case .removeCard(_):
            return .delete
        case .updatePromotionAndCard(_, _):
            return .put
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .addPromotion(let promotion):
            return Task.requestParameters(parameters: promotion, encoding: JSONEncoding.default)
        case .updatePromotionAndCard(let promotions, let cards):
            let params = ["cards" : cards, "promotion_code" : promotions]
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .addCard(let cardToken):
            let params = ["payment_token" : cardToken]
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        default:
            return Task.requestPlain
        }
    }
    
}

