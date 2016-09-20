//
//  StationsViewModel.swift
//  itstime
//
//  Created by Martin Moizard on 18/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import RxSwift
import enum Result.Result

class StationsViewModel {
    let stations: Observable<Result<[Station], NSError>>
    
    init(_ stations: Observable<Result<[Station], NSError>>) {
        self.stations = stations
    }
}
