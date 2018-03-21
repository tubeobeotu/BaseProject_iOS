import Foundation

public extension ObservableType where E == Response  {
  
  
  public func retryWithAuthIfNeeded() -> Observable<Response> {
    
    return self.retryWhen({ (error: Observable<Error>)  in
      
      return Observable.zip(error, Observable
        .range(start: 1, count: 3), resultSelector: { ($0,$1) })
        .flatMap { i -> Observable<Token> in
          
          if case MoyaError.underlying(let errorCode, let response) = i.0,
            let statusCode = response?.statusCode, statusCode == 401 {
            
            if let errorCode = errorCode as? ABError,
              Int(errorCode.code) == 22001 { // Catching multiple device login here
              ABAppState.sharedInstance.state = .Finish
              return WireFrameDefault
                .shared
                .promptForNetworkingError(code: errorCode.code, cancelAction: AlertAction.ok, actions: [])
                .flatMapLatest { _ -> Observable<Token> in
                  
                  if let customer = Customer.signedInCustomer {
                    let realm = try! Realm()
                    if let currentFcmToken = FcmToken.currentFcmToken(realm) {
                      
                      let requestUnregisFcm = NetworkProvider.requestEmptyObject(FirebaseFCMAPI.unregisToken(fcmToken: currentFcmToken.currentToken ?? ""), onLoadingView: true).share(replay: 1)
                      
                      _ = requestUnregisFcm
                        .elements()
                        .flatMapLatest { _ -> Observable<()> in
                          _ =  FcmToken.removeFcmToken(realm, fcmToken: currentFcmToken)
                          return Customer.logout(realm, customer: customer)
                        }
                        .subscribe()
                      
                      _ = requestUnregisFcm
                        .errors()
                        .flatMapLatest { _ in
                          return WireFrameDefault.shared.promptFor(message: AlertMessage.errorLogout, cancelAction: AlertAction.ok, actions: [])
                        }
                        .subscribe()
                      
                    } else {
                      Customer
                        .logout(realm, customer: customer)
                        .subscribe()
                        .dispose()
                    }
                    
                    return Observable.empty()
                  }
                  
                  return Observable.empty()
              }
              
            } else if let errorCode = errorCode as? ABError,
              Int(errorCode.code) == 401 { // Catching unauth here
              return provider
                .rx
                .request(MultiTarget(AuthAPI.refreshAccessToken()))
                .asObservable()
                .mapObject(Token.self)
                .catchError { (error) in
                  if case MoyaError.underlying(_, let response) = error {
                    if response?.statusCode == 401 {
                      if let customer = Customer.signedInCustomer {
                        let realm = try! Realm()
                        if let currentFcmToken = FcmToken.currentFcmToken(realm) {
                          
                          let requestUnregisFcm = NetworkProvider.requestEmptyObject(FirebaseFCMAPI.unregisToken(fcmToken: currentFcmToken.currentToken ?? ""), onLoadingView: true).share(replay: 1)
                          
                          requestUnregisFcm
                            .elements()
                            .flatMapLatest { _ in
                              return FcmToken.removeFcmToken(realm, fcmToken: currentFcmToken)
                            }
                            .flatMapLatest { _ in
                              return Customer.logout(realm, customer: customer)
                            }
                            .subscribe()
                            .dispose()
                          
                          
                          requestUnregisFcm
                            .errors()
                            .flatMapLatest { _ in
                              return WireFrameDefault.shared.promptFor(message: AlertMessage.errorLogout, cancelAction: AlertAction.ok, actions: [])
                            }
                            .subscribe()
                            .dispose()
                          
                        } else {
                          Customer
                            .logout(realm, customer: customer)
                            .subscribe()
                            .dispose()
                        }
                        
                        return Observable.empty()
                      }
                    }
                  }
                  return Observable.error(error)
                }
                .flatMapLatest({ (token) -> Observable<Token> in
                  let realm = try! Realm()
                  if !Customer.updateToken(realm, token: token) {
                    if let customer = Customer.signedInCustomer {
                      _ = Customer.logout(realm, customer: customer).subscribe()
                    }
                  }
                  return Observable.just(token)
                })
            } else {
              return Observable.empty()
            }
            
          } else {
            return Observable.error(i.0)
          }
          
      }
    })
  }
}


