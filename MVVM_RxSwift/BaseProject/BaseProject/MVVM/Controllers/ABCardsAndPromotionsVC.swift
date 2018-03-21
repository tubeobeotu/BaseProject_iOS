
import UIKit

class ABCardsAndPromotionsVC: ABBaseLeftMenuWithRefreshTableVC <ABCardAndPromotionViewModel> {
  
    let currencyCode = Store.currentStore?.currencyCode ?? "USD"
    let customer = Customer.signedInCustomer
    var sections = Variable<[SectionOfPaymentAndPromotion]>([])
    var isEdit = Variable<Bool>(false)
    var isAddingPromotion = false
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfPaymentAndPromotion>(
        configureCell: { (_, tv, ip, section: SectionOfPaymentAndPromotion.Row) in
            switch section {
            case .header(let content):
                if let cell = tv.dequeueReusableCell(withIdentifier: "ABHeaderViewCell", for: ip) as? ABHeaderViewCell
                {
                    cell.setDataForCell(title: content)
                    return cell
                }
                break
            case .promotion(let coupon, let target):
                if(coupon != nil)
                {
                    if let cell = tv.dequeueReusableCell(withIdentifier: "ABPromotionCell", for: ip) as? ABPromotionCell
                    {
                        cell.setDataForCell(name: coupon!.name ?? "")
                        if(cell.isSubcribe == false)
                        {
                            cell.isSubcribe = true
                            cell.deletePromotion.subscribe({ _ in
                                target?.viewModel.deletePromotion(promotionId: coupon!.id ?? "")
                            }).disposed(by: target!.bag)
                        }
                        return cell
                    }
                }
                break
            case .card(let card):
                if let cell = tv.dequeueReusableCell(withIdentifier: "ABConfirmOrderPaymentCell", for: ip) as? ABConfirmOrderPaymentCell
                {
                    cell.setDataForCell(card: card)
                    return cell
                }
                break
            case .newPayment():
                if let cell = tv.dequeueReusableCell(withIdentifier: "ABAddingNewItemCell", for: ip) as? ABAddingNewItemCell
                {
                    cell.btn_Action.isHidden = true
                    cell.setupDataForCell(title: "Add payment options".localized())
                    return cell
                }
                break
            case .newPromotion(let isEdit, let target):
                if(isEdit == false)
                {
                    if let cell = tv.dequeueReusableCell(withIdentifier: "ABAddingNewItemCell", for: ip) as? ABAddingNewItemCell
                    {
                        cell.setupDataForCell(title: "Add promotion code".localized())
                        cell.btn_Action.isHidden = true
                        return cell
                    }
                }else
                {
                    if let cell = tv.dequeueReusableCell(withIdentifier: "ABAddPromotionCell", for: ip) as? ABAddPromotionCell
                    {
                        cell.tf_Content.becomeFirstResponder()
                        if(cell.isSubcribe == false)
                        {
                            cell.isSubcribe = true
                            cell.addNewPromotion.subscribe({ _ in
                                target?.viewModel.verifyPromotion(code: cell.tf_Content.text ?? "")
                                cell.tf_Content.text = ""
                            }).disposed(by: target!.bag)
                        }
                        
                        return cell
                    }
                }
                
                break
            case .empty():
                if let cell = tv.dequeueReusableCell(withIdentifier: "ABEmptyCell", for: ip) as? ABEmptyCell
                {
                    return cell
                }
                break
            }
            return UITableViewCell()
    },
        titleForHeaderInSection: { dataSource, sectionIndex in
            let section = dataSource[sectionIndex]
            return section.header
    }
    )
    @objc func pushToAddingNewAddress()
    {
        //        self.viewModel.pushToAddingNewAddress()
    }
    
    func setupView()
    {
        self.disableLoadMore()
        mainTableView.register(nibName: "ABHeaderViewCell")
        mainTableView.register(nibName: "ABPromotionCell")
        mainTableView.register(nibName: "ABConfirmOrderPaymentCell")
        mainTableView.register(nibName: "ABAddingNewItemCell")
        mainTableView.register(nibName: "ABAddPromotionCell")
        mainTableView.separatorStyle = .none
        self.title = "Payment and promotion".localized().uppercased()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    override func loadData(page: Int, isRefresh: Bool) {
        self.viewModel.getListCardsAndPromotions(isRefresh: isRefresh)
    }
    
    func refreshTable()
    {
        self.mainTableView.status = .Normal
        self.isEdit.value = false
    }
    func reloadGetCardsAndPromotions()
    {
        self.viewModel.getListCardsAndPromotions(isRefresh: true)
    }
    
    func showPromotionDetail(promotion: Coupon?)
    {
        if(promotion == nil)
        {
            return
        }
        let promotionVC = ABPromotionDescriptionVC.instantiateFromXib()
        promotionVC.promotion = promotion!
        let formSheetController = MZFormSheetPresentationViewController(contentViewController: promotionVC)
        formSheetController.presentationController?.contentViewSize = UILayoutFittingCompressedSize
        formSheetController.presentationController?.shouldDismissOnBackgroundViewTap = true
        promotionVC.close.subscribe({_ in
            formSheetController.dismiss(animated: true, completion: nil)
        }).disposed(by: bag)
        self.present(formSheetController, animated: true, completion: nil)
        
    }
    
}

extension ABCardsAndPromotionsVC:Bindable
{
    func calculateSections()
    {
        weak var weak = self
        let subSections = [
            SectionOfPaymentAndPromotion.header(header: "", items: [.header(content: "payment options".localized().uppercased())]),
            SectionOfPaymentAndPromotion.header(header: "", items: self.getCards()),
            SectionOfPaymentAndPromotion.header(header: "", items: [.newPayment()]),
            SectionOfPaymentAndPromotion.header(header: "", items: [.header(content: "promotions".localized().uppercased())]),
            SectionOfPaymentAndPromotion.header(header: "", items: self.getPromotion()),
            SectionOfPaymentAndPromotion.header(header: "", items: [.newPromotion(isEdit: self.isEdit.value, target: weak)]),
            ]
        sections.value = subSections
    }
    func getCards() -> [SectionOfPaymentAndPromotion.Row]
    {
        var cards = [SectionOfPaymentAndPromotion.Row]()
        if let cardModels = self.viewModel.listCardsAndPromotions.value.cards
        {
            for card in cardModels
            {
                cards.append(.card(card: card ))
            }
        }
        return cards
    }
    func getPromotion() -> [SectionOfPaymentAndPromotion.Row]
    {
        weak var weak = self
        var promotions = [SectionOfPaymentAndPromotion.Row]()
        if let promotionModels = self.viewModel.listCardsAndPromotions.value.promotions
        {
            for promotion in promotionModels
            {
                promotions.append(.promotion(coupon: promotion, target: weak))
            }
        }
        return promotions
    }
    
    func bindViewModel() {
        self.viewModel.listCardsAndPromotions
            .asObservable()
            .subscribe({_ in
                self.refreshTable()
            })
            .disposed(by: bag)
        
        self.viewModel.requestSubject
            .asObservable()
            .subscribe(onNext:{[weak self] (model) in
                if(self?.checkError(model: model) == .Success)
                {
                    if let successVerifedModel = model as? Coupon
                    {
                        if(self?.isEdit.value == true)
                        {
                            if(self?.isAddingPromotion == false)
                            {
                                self?.isAddingPromotion = true
                                self?.viewModel.addPromotion(promotion: successVerifedModel.toDictionary())
                            }else
                            {
                                self?.reloadGetCardsAndPromotions()
                                self?.isAddingPromotion = false
                            }
                        }
                        
                    }
                    else if let deletedModel = model as?  PromotionDeleteModel
                    {
                        self?.showAlertViewDefaul(message: deletedModel.message ?? "")
                        self?.reloadGetCardsAndPromotions()
                    }
                }
            })
            .disposed(by: bag)
        
        
        self.isEdit
            .asObservable()
            .subscribe({_ in
                self.calculateSections()
            })
            .disposed(by: bag)
        
        
        sections
            .asObservable()
            .bind(to: mainTableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        mainTableView
            .rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let type = SectionOfPaymentAndPromotionType(rawValue: indexPath.section)
                {
                    switch(type)
                    {
                    case .card:
                        self?.viewModel.showCardDetailVC(card: self?.viewModel.listCardsAndPromotions.value.cards![indexPath.row])
                        break
                    case .newPayment:
                        self?.viewModel.showAddPaymentVC()
                        break
                    case .promotion:
                        self?.showPromotionDetail(promotion: self?.viewModel.listCardsAndPromotions.value.promotions![indexPath.row])
                        break
                    case .newPromotion:
                        if(self?.isEdit.value == false)
                        {
                            self?.isEdit.value = true
                        }
                        break
                    default:
                        break
                    }
                }
                
            })
            .disposed(by: bag)
        
    }
    
}


