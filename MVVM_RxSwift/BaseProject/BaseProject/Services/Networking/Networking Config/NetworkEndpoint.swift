import Foundation

struct PromotionAndCardEndPoint
{
    static let verifyPromotion = "stores/\(storeId)/branches/\(Branch.currentBranch?.id ?? brancheId)/promotions/" //{code}
    static let listPromotion = "stores/\(storeId)/branches/\(brancheId)/promotions/"
    static let listCardAndPromotions = "stores/\(storeId)/card-promotion"
    static let addPromotion = "stores/\(storeId)/promotions"
    static let deletePromotion = "stores/\(storeId)/branches/\(brancheId)/promotions/" //{promotion_id}
    static let updatePromotionAndCard = "api/stores/\(storeId)/card-promotion"
    static let addCard = "stores/\(storeId)/card/link"
    static let removeCard = "stores/\(storeId)/card/"
    
}

