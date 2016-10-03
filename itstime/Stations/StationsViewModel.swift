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

class StationsViewModel {
    enum TableContent {
        case StationRow(Station)
        case ErrorRow(Error)
    }
    
    let tableDriver: Driver<[TableContent]>
    
    init(_ driver: Driver<[TableContent]>) {
        self.tableDriver = driver
    }
}
