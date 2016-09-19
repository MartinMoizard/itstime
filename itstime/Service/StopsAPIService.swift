//
//  StopsAPIService.swift
//  itstime
//
//  Created by Martin Moizard on 18/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
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
    
    static func search(withName name: String) -> Promise<[Station]> {
        return Promise { fulfill, reject in
            request(ResourcePath.stops.path, method: .get, parameters: ["qq": name]).responseArray { (response: DataResponse<[Station]>) -> () in
                if response.result.isSuccess {
                    fulfill(response.result.value ?? [])
                } else {
                    reject(response.result.error ?? NSError.timeForAnError(NSLocalizedString("Could fetch results", comment: "")))
                }
            }
        }
    }
}
