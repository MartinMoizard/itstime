//
//  StationViewModel.swift
//  itstime
//
//  Created by Martin Moizard on 17/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StationViewModel {
    private let station: Observable<Station>
    
    let name: Observable<String>
    
    init(_ station: Station) {
        self.station = Observable.just(station)
        self.name = self.station.map { $0.name }
    }
}
