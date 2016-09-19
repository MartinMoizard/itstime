//
//  StationsViewModel.swift
//  itstime
//
//  Created by Martin Moizard on 18/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import RxSwift

class StationsViewModel {
    let stations: Observable<[Station]>
    
    init(_ stations: Observable<[Station]>) {
        self.stations = stations
    }
}
