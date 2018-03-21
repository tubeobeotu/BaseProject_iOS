//
//  ABCardAndPromotionViewModel.swift
//  AB Branded App
//
//  Created by Nguyen Van Tu on 1/5/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation
//import Stripe

class ABCardAndPromotionViewModel: BaseViewModel {
  
    var listCardsAndPromotions = Variable<CardsAndPromotions>(CardsAndPromotions())
    var requestSubject = Variable<Any>((Any).self)
    func showCardDetailVC(card: CustomerCard?)
    {
        if(card == nil)
        {
            return
        }
        let cardDetailVM = ABCardDetailViewModel(self.screenCoordinator)
        cardDetailVM.needReload
            .asObservable()
            .subscribe(onNext:{ [weak self] (value) in
                if(value == true)
                {
                    self?.getListCardsAndPromotions(isRefresh: true)
                }
            })
            .disposed(by: bag)
        cardDetailVM.card.value = card!
        let _ = self.screenCoordinator.transition(to: .cardDetail(cardDetailVM), type: .push)
    }
    
    
    func showAddPaymentVC()
    {
        let addPaymentVM = ABAddPaymentViewModel(self.screenCoordinator)
        addPaymentVM.needReload
            .asObservable()
            .subscribe(onNext:{ [weak self] (value) in
                if(value == true)
                {
                    self?.getListCardsAndPromotions(isRefresh: true)
                }
            })
            .disposed(by: bag)
        let _ =  self.screenCoordinator.transition(to: .addingPayment(addPaymentVM), type: .push)
    }
    override func initValue() {
        //        self.getListPromotions()
//        self.getListCardsAndPromotions()
    }
    func getListCardsAndPromotions(isRefresh: Bool)
    {
        let list  = PromotionsAndCardsProviders.getListCardsAndPromotions(onLoadingView: !isRefresh, bag: bag)
        list.elements()
            .bind(to: self.listCardsAndPromotions)
            .disposed(by: bag)
    }
    func verifyPromotion(code: String)
    {
        let observable = PromotionsAndCardsProviders.verifyPromotion(code: code, onLoadingView: true, bag: bag)
        observable
            .elements()
            .subscribe(onNext: { (onNextModel) in
                self.requestSubject.value = onNextModel
            }).disposed(by: bag)
        
        observable
            .errors()
            .subscribe(onNext: { (error) in
                self.requestSubject.value = error
            }).disposed(by: bag)
    }
    func addPromotion(promotion: Dictionary<String, Any>)
    {
        let observable = PromotionsAndCardsProviders.addPromotion(promotion: promotion, onLoadingView: true, bag: bag)
        observable
            .elements()
            .subscribe(onNext: { (onNextModel) in
                self.requestSubject.value = onNextModel
            }).disposed(by: bag)
        
        observable
            .errors()
            .subscribe(onNext: { (error) in
                self.requestSubject.value = error
            }).disposed(by: bag)
    }
  
    func deletePromotion(promotionId: String)
    {
        let observable = PromotionsAndCardsProviders.deletePromotion(promotionId: promotionId, onLoadingView: true, bag: bag)
        observable
            .elements()
            .subscribe(onNext: { (onNextModel) in
                self.requestSubject.value = onNextModel
            }).disposed(by: bag)
        
        observable
            .errors()
            .subscribe(onNext: { (error) in
                self.requestSubject.value = error
            }).disposed(by: bag)
    }
    
    //    func updatePromotionAndCard()
    //    {
    //        let promotions = self.listCardsAndPromotions.value.getListPromotions()
    //        let cards = self.listCardsAndPromotions.value.getListCards()
    //        let observable = PromotionsAndCardsProviders.updatePromotionAndCard(promotions: promotions, cards: cards)
    //        observable.elements().subscribe(onNext: { (onNextModel) in
    //            self.requestSubject.value = onNextModel
    //        }).disposed(by: bag)
    //
    //        observable.errors().subscribe(onNext: { (error) in
    //            self.requestSubject.value = error
    //        }).disposed(by: bag)
    //    }
    
    
    
}
