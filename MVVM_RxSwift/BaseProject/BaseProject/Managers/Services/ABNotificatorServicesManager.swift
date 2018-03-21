import Foundation
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
enum NotificationType: String{
  case unknown = ""
  case order_accepted = "order_accepted"
  case order_rescheduled = "order_rescheduled"
  case order_rejected = "order_rejected"
  case order_review = "order_review"
  case order_finished = "order_finished"
  case store_reactived = "store_reactivated"
  case order_cancelled = "order_cancelled"
}

class NotificationObj: NSObject
{
  var type = NotificationType.unknown
  var order_number: String = ""
  var isTouch = false
}

class ABNotificatorServicesManager: NSObject
{
  let bag = DisposeBag()
  var notification = Variable<NotificationObj>(NotificationObj())
  var tmpNotification:NotificationObj?
  var isCloseApp = false
  static let sharedInstance: ABNotificatorServicesManager = {
    let instance = ABNotificatorServicesManager()
    instance.addSubcribe()
    return instance
  }()
  
  override init() {
    
  }
  
  func regisPushTopic() {
    //Regis for receive re-active store notification
    Messaging.messaging().subscribe(toTopic: "store-\(storeId)-ios")
  }
  
  func addSubcribe()
  {
    self.notification.asDriver()
      .drive(onNext: { (notification) in
        self.actionWhenReceving(notification: notification)
      })
      .disposed(by: bag)
  }
  
  func checkNotiType(userInfo: [AnyHashable : Any], isTouch: Bool)
  {
    tmpNotification = nil
    if let rawType = userInfo["type"] as? String{
      if let orderType = NotificationType(rawValue: rawType)
      {
        let notification = NotificationObj()
        notification.type = orderType
        notification.isTouch = isTouch
        if let rawOrderNumber = userInfo["order_number"] as? String
        {
          notification.order_number = rawOrderNumber
        }

        if(isCloseApp == true)
        {
          tmpNotification = notification
        }else
        {
          ABNotificatorServicesManager.sharedInstance.notification.value = notification
        }
        
      }
    }
  }
  
  func actionWhenReceving(notification: NotificationObj)
  {
    switch notification.type {
    case .order_review:
      if(notification.isTouch == true)
      {
        let feedBackVM = ABFeedBackViewModel(ScreenCoordinator.sharedInstance, orderId: notification.order_number, isNotification: true)
        let _ = ScreenCoordinator.sharedInstance.transition(to: .feedback(feedBackVM), type: .modal)
      }
      
      break
      
    case .order_finished, .order_rejected:
      if(notification.isTouch == true)
      {
        let orderDetailViewModel = ABOrderHistoryDetailViewModel.init(ScreenCoordinator.sharedInstance, orderId: notification.order_number, isNotification: true)
        let _ = ScreenCoordinator.sharedInstance.transition(to: .orderDetailHistory(orderDetailViewModel), type: .modal)
      }
      
      break
      
    case .order_accepted, .order_rescheduled:
      if(notification.isTouch == true)
      {
        let orderDetailViewModel = ABIncomingOrderDetailViewModel(ScreenCoordinator.sharedInstance, orderId: notification.order_number, isNotification: true)
        let _ = ScreenCoordinator.sharedInstance.transition(to: .incomingOrderDetail(orderDetailViewModel), type: .modal)
      }
      break
      
    case .store_reactived:
      if notification.isTouch {
        if let _ = UIViewController.getTopVC() as? ABDeactiveStoreVC {
          NotificationCenter.default.post(name: NSNotification.Name.init("DidReactivated"), object: nil)
        }
      }
    default:
      break
    }
    
  }
}

extension AppDelegate
{
  //Register for push notification.
  func registerForPushNotifications(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
    FirebaseApp.configure()
    if #available(iOS 10.0, *) {
      let center  = UNUserNotificationCenter.current()
      center.delegate = self
      center.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
        if error == nil{
          DispatchQueue.main.async(execute: {
            application.registerForRemoteNotifications()
          })
        }
      }
    }
    else {
      
      let settings = UIUserNotificationSettings(types: [.alert,.sound], categories: nil)
      application.registerUserNotificationSettings(settings)
      application.registerForRemoteNotifications()
    }
    // Add observer for InstanceID token refresh callback.
    NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
    
    
    Messaging.messaging().delegate = self
    if let token = InstanceID.instanceID().token() {
      NSLog("FCM TOKEN : \(token)")
      self.connectToFcm()
    }
    if launchOptions != nil {
      //opened from a push notification when the app is closed
      _ = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] ?? [AnyHashable: Any]()
    }
    else {
      //opened app without a push notification.
    }
  }
  
  @objc func tokenRefreshNotification(_ notification: Notification) {
    print(#function)
    if let refreshedToken = InstanceID.instanceID().token() {
      NSLog("Notification: refresh token from FCM -> \(refreshedToken)")
    }
    // Connect to FCM since connection may have failed when attempted before having a token.
    connectToFcm()
  }
  
  func connectToFcm() {
    // Won't connect since there is no token
    guard InstanceID.instanceID().token() != nil else {
      NSLog("FCM: Token does not exist.")
      return
    }
    
    Messaging.messaging().shouldEstablishDirectChannel = true
    
    if let _ = Customer.signedInCustomer?.token?.accessToken {
      
      let realm = try! Realm()
      
      if let currentFcmToken = FcmToken.currentFcmToken(realm)?.currentToken {
        unregisFcmTokenAndRegis(currentFcmToken)
      } else {
        regisFcmToken()
      }
      
    }
    
  }
  
  func regisFcmToken() {
    
    let realm = try! Realm()
    
    if let fcmToken = InstanceID.instanceID().token() {
      NetworkProvider
        .requestEmptyObject(FirebaseFCMAPI.regisToken(fcmToken: fcmToken))
        .elements()
        .subscribe(onNext: { _ in
          let fcmToken = FcmToken(fcmToken)
          FcmToken.createFcmToken(realm, fcmToken: fcmToken)
        })
        .disposed(by: rx.disposeBag)
    }
    
    
  }
  
  func unregisFcmTokenAndRegis(_ currentFcmToken: String) {
    
    let realm = try! Realm()
    
    NetworkProvider
      .requestEmptyObject(FirebaseFCMAPI.unregisToken(fcmToken: currentFcmToken))
      .elements()
      .flatMapLatest { _ in
        return NetworkProvider.requestEmptyObject(FirebaseFCMAPI.regisToken(fcmToken: InstanceID.instanceID().token() ?? "")).elements()
      }
      .subscribe(onNext: { _ in
        let fcmToken = FcmToken.init(InstanceID.instanceID().token()!)
        FcmToken.createFcmToken(realm, fcmToken: fcmToken)
      })
      .disposed(by: rx.disposeBag)
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    NSLog("Notification: Unable to register for remote notifications: \(error.localizedDescription)")
  }
  
  
  // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
  // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to the InstanceID token.
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
  }
  
  // iOS9, called when presenting notification in foreground
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    //same with present ios 10
    ABNotificatorServicesManager.sharedInstance.checkNotiType(userInfo: userInfo, isTouch: false)
    NSLog("didReceiveRemoteNotification for iOS9: \(userInfo)")
    
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    //same with didReceive ios 10
    ABNotificatorServicesManager.sharedInstance.checkNotiType(userInfo: userInfo, isTouch: true)
    NSLog("didReceiveRemoteNotification22 for iOS9: \(userInfo)")
    completionHandler(.newData)
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  // iOS10+, called when presenting notification in foreground
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo
    ABNotificatorServicesManager.sharedInstance.checkNotiType(userInfo: userInfo, isTouch: false)
    NSLog("[UserNotificationCenter] willPresentNotification: \(userInfo)")
    //TODO: Handle foreground notification
    completionHandler([.alert])
  }
  
  // iOS10+, called when received response (default open, dismiss or custom action) for a notification
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    ABNotificatorServicesManager.sharedInstance.checkNotiType(userInfo: userInfo, isTouch: true)
    NSLog("[UserNotificationCenter] didReceiveResponse: \(userInfo)")
    //TODO: Handle background notification
    completionHandler()
  }}

extension AppDelegate : MessagingDelegate {
  //MARK: FCM Token Refreshed
  func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
    NSLog("[RemoteNotification] didRefreshRegistrationToken: \(fcmToken)")
    ABNotificatorServicesManager.sharedInstance.regisPushTopic()
  }
  
  //   Receive data message on iOS 10 devices while app is in the foreground.
  func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    NSLog("remoteMessage: \(remoteMessage.appData)")
    Messaging.messaging().appDidReceiveMessage(remoteMessage.appData)
    ABNotificatorServicesManager.sharedInstance.checkNotiType(userInfo: remoteMessage.appData, isTouch: false)
  }
}

