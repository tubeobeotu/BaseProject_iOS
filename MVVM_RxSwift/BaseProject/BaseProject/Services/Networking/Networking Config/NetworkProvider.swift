import Foundation

struct NetworkProvider {

    private init() {}

    static func requestObject<T: Mappable>(_ objectMapping: T.Type, _ target: TargetType, onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<T>> {

        let request = provider
            .rx
            .request(MultiTarget(target))
            .asObservable()
            .retryWithAuthIfNeeded()            
            .share(replay: 1)


        if(onLoadingView == true)
        {
            ABAppState.sharedInstance.state = .Loading
            request.subscribe({ _ in
                ABAppState.sharedInstance.state = .Finish
            })
                .disposed(by: bag)
        }
        return  request
            .mapObject(T.self)
            .materialize()

    }

    static func requestArrayObject<T: Mappable>(_ objectMapping: T.Type, _ target: TargetType, onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<[T]>> {
        let request = provider.rx
            .request(MultiTarget(target))
            .asObservable()
            .retryWithAuthIfNeeded()
            .share(replay: 1)

        if(onLoadingView == true)
        {
            ABAppState.sharedInstance.state = .Loading
            request.subscribe({ _ in
                ABAppState.sharedInstance.state = .Finish
            })
                .disposed(by: bag)
        }
        return request
            .mapArray(T.self)
            .materialize()
    }

    static func requestEmptyObject(_ target: TargetType, onLoadingView: Bool = false, bag: DisposeBag = DisposeBag()) -> Observable<Event<Response>>{
        let request = provider.rx
            .request(MultiTarget(target))
            .asObservable()
            .retryWithAuthIfNeeded()
            .share(replay: 1)

        if(onLoadingView == true)
        {
            ABAppState.sharedInstance.state = .Loading
            request.subscribe({ _ in
                ABAppState.sharedInstance.state = .Finish
            })
                .disposed(by: bag)
        }

        return request
            .materialize()

    }



}
