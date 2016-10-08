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
import Action

class StationsViewModel : ComponentViewModel {
    enum TableContent {
        case stationRow(Station)
        case errorRow(Error)
    }
    
    // Output
    var showStation: Action<TableContent, Void> {
        return Action {
            [weak self] item in
            guard let strongSelf = self else { return Observable.empty() }
            switch item {
            case .stationRow(let station):
                let stationVm = StationViewModel(withCoordinator: strongSelf.coordinator, andStation: station)
                strongSelf.coordinator.transition(toViewModel: stationVm)
                break
            default:
                break
            }
            return Observable.empty()
        }
    }
    
    // Input
    let tableDriver: Driver<[TableContent]>
    var tableContentInset = Driver.just(UIEdgeInsets.zero)
    
    init(withCoordinator coordinator: Coordinator, andTableDriver driver: Driver<[TableContent]>) {
        self.tableDriver = driver
        super.init(coordinator)
    }
}
