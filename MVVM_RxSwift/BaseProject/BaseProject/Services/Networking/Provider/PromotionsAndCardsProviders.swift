import Foundation


class PromotionsAndCardsProviders {
    
    static func getListPromotions(onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<[Coupon]>>
    {
        return NetworkProvider.requestArrayObject(Coupon.self, PromotionAndCardAPI.getListPromotion(), onLoadingView: onLoadingView, bag: bag)
    }
    
    static func getListCardsAndPromotions(onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<CardsAndPromotions>>
    {
        return NetworkProvider.requestObject(CardsAndPromotions.self, PromotionAndCardAPI.getListCardAndPromotions(), onLoadingView: onLoadingView, bag: bag)
    }
    
    static func verifyPromotion(code: String, onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<Coupon>>
    {
        return NetworkProvider.requestObject(Coupon.self, PromotionAndCardAPI.verifyPromoion(code: code), onLoadingView: onLoadingView, bag: bag)
    }
    
    static func addPromotion(promotion: Dictionary<String, Any>, onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<Coupon>>
    {
        return NetworkProvider.requestObject(Coupon.self, PromotionAndCardAPI.addPromotion(promotion: promotion), onLoadingView: onLoadingView, bag: bag)
    }
    
    static func deletePromotion(promotionId: String, onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<PromotionDeleteModel>>
    {
        return NetworkProvider.requestObject(PromotionDeleteModel.self, PromotionAndCardAPI.deletePromotion(promotionId: promotionId), onLoadingView: onLoadingView, bag: bag)
    }
    
    static func updatePromotionAndCard(promotions: [Dictionary<String, Any>], cards: [Dictionary<String, Any>], onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<[CardsAndPromotions]>>
    {
        return NetworkProvider.requestArrayObject(CardsAndPromotions.self, PromotionAndCardAPI.updatePromotionAndCard(promotions: promotions, cards: cards), onLoadingView: onLoadingView, bag: bag)
    }
    
    static func addCard(cardToken: String, onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<CustomerCard>>
    {
        return NetworkProvider.requestObject(CustomerCard.self, PromotionAndCardAPI.addCard(cardToken: cardToken), onLoadingView: onLoadingView, bag: bag)
    }
    
    static func deleteCard(cardId: String, onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<Response>>
    {
        return NetworkProvider.requestEmptyObject(PromotionAndCardAPI.removeCard(cardId: cardId), onLoadingView: onLoadingView, bag: bag)
    }
    
}
