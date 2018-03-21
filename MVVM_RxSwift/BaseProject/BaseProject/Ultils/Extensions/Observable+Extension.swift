//
//  Observable+Exntension.swift
//  AB Branded App
//
//  Created by Nguyen Van Tu on 12/26/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension String
{
    func toObservable() -> Observable<String>
    {
        return Observable.of(self)
    }
}

extension Int
{
    func toObservable() -> Observable<Int>
    {
        return Observable.of(self)
    }
}

extension Double
{
    func toObservable() -> Observable<Double>
    {
        return Observable.of(self)
    }
}

extension Bool
{
    func toObservable() -> Observable<Bool>
    {
        return Observable.of(self)
    }
}

