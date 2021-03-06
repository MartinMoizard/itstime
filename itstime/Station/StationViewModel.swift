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

class StationViewModel : ComponentViewModel {
    private let station: Observable<Station>
    
    let name: Observable<String>
    
    init(withCoordinator coordinator: Coordinator, andStation station: Station) {
        self.station = Observable.just(station)
        self.name = self.station.map { $0.name }
        super.init(coordinator)
    }
}
