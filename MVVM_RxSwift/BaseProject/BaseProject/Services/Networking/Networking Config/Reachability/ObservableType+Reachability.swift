import Foundation
import Reachability
import RxCocoa
import RxSwift

public extension ObservableType {
  
  public func retryOnConnect(timeout: TimeInterval) -> Observable<E> {
    return retryWhen { _ in
      return Reachability.rx.isConnected
        .timeout(timeout, scheduler: MainScheduler.asyncInstance)
    }
  }
}
