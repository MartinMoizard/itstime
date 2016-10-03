//
//  StopsAPIService.swift
//  itstime
//
//  Created by Martin Moizard on 18/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import AlamofireObjectMapper

final class StopsAPIService {
    private struct Constants {
        static let baseUrl = "https://itstime.herokuapp.com"
    }
    
    enum ResourcePath: String {
        case stops = "/stops"
        case nextStops = "/nextStops"
        
        var path: String {
            return Constants.baseUrl + rawValue
        }
    }
    
    static func search(withName name: String) -> Observable<[Station]> {
        return Observable.create { observer in
            request(ResourcePath.stops.path, method: .get, parameters: ["q": name]).responseArray { (response: DataResponse<[Station]>) -> Void in
                if response.result.isSuccess {
                    observer.onNext(response.result.value ?? [])
                    observer.onCompleted()
                } else {
                    observer.onError(response.result.error ?? NSError.timeForAnError(NSLocalizedString("Could fetch results", comment: "")))
                }
            }
            return Disposables.create()
        };
    }
}
