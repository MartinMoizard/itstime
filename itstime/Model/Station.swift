//
//  Station.swift
//  itstime
//
//  Created by Martin Moizard on 17/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import ObjectMapper

class Station: Mappable {
    var id: Int!
    var name: String!
    var lines: [Line] = []
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        lines <- map["lines"]
    }
}
