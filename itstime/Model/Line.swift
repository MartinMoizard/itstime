//
//  Line.swift
//  itstime
//
//  Created by Martin Moizard on 18/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import ObjectMapper

class Line: Mappable {
    enum Mode: String {
        case metro
        case rer
        case bus
        case noctilien
        case tram
    }
    
    var id: Int!
    var name: String!
    var mode: Mode!
    var directions: [Direction] = []
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        mode <- map["transport.mode"]
        directions <- map["directions"]
    }
}
