//
//  StationsViewModel.swift
//  itstime
//
//  Created by Martin Moizard on 18/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StationsViewModel : ComponentViewModel {
    enum TableContent {
        case stationRow(Station)
        case errorRow(Error)
    }
    
    // Input
    let tableDriver: Driver<[TableContent]>
    var tableContentInset = Driver.just(UIEdgeInsets.zero)
    
    init(withCoordinator coordinator: Coordinator, andTableDriver driver: Driver<[TableContent]>) {
        self.tableDriver = driver
        super.init(coordinator)
    }
}
