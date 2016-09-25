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
    enum TableContent {
        case StationRow(Station)
        case ErrorRow(Error)
    }
    
    let tableObservable: Observable<[TableContent]>
    
    init(_ observable: Observable<[TableContent]>) {
        self.tableObservable = observable
    }
}
