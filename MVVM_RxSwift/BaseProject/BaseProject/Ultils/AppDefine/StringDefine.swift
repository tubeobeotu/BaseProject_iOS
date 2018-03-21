//
//  StringDefine.swift
//  AB Branded App
//
//  Created by Lucio Pham on 1/10/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation

struct NavigationTitle {
  static let selectItem = "toolbar_order_step_2_selection".localized()
  static let myCart = "toolbar_my_cart".localized()
  static let detailItem = "toolbar_item_detail".localized()
  static let confirmOrder = "toolbar_order_step_3_confirmation".localized()
  static let promotionCode = "toolbar_promotion_code".localized()
  static let paymentMethod = "toolbar_payment_method".localized()
  static let scheduleOrder = "toolbar_custom_schedule".localized()
  static let loyaltyReward = "toolbar_royalty_reward".localized()
}

struct BarButtonTitle {
  static let clearCart = "CLEAR".localized()
}

struct AlertMessage {
  static let rewardOutOfDate = "Your loyalty reward coupon is out of date, please use another.".localized()
  static let noAddressForDeliveryItems = "Please choose address you want to delivery your items !!".localized()
  static let noNetworking = "It's seem like your network is offline, please check again !!".localized()
  static let emptyItemForOrder = "Please select at least one item before confirm your order".localized()
  static let confirmClearCart = "Are you sure to remove all items from  your cart ?".localized()
  static let failedLogout = "Can't logout this time, please try again".localized()
  static let confirmLogout = "Are you sure? Logging out will remove all ChopOrder data from this device".localized()
  static let pickingWrongScheduleTime = "Please select right time for picking or delivery your orders".localized()
  static let pickingScheduleTimeOutOfOpenCloseTime = "\(Branch.currentBranch?.name ?? "") opens from \(Branch.currentBranch?.opentime.filter { $0.day == Date().currentDayOfWeek() }.first?.hours.toArray().map {"\($0.openTime ?? "00:00") to \($0.closeTime ?? "00:00")"}.joined(separator: ",") ?? ""). Please come back later or select another branch.".localized()
  static let emptyInformation = "Customer name or customer phone number cannot be empty".localized()
  static let emptyCard = "Please add a card before submit your order".localized()
  static let errorLogout = "Something wrong. Please try log-out again !!!".localized()
}

struct AlertAction {
  static let dismiss = "DISMISS".localized()
  static let cancel = "CANCEL".localized()
  static let yes = "YES".localized()
  static let ok = "OK".localized()
}
