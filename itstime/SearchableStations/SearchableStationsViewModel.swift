//
//  SearchableStationsViewModel.swift
//  itstime
//
//  Created by Martin MOIZARD-LANVIN on 19/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchableStationsViewModel {
    let search: PublishSubject<String> = PublishSubject<String>()
    lazy var tableDriver: Driver<[StationsViewModel.TableContent]> = self.stationsDriver()
    lazy var stationsViewModel: StationsViewModel = StationsViewModel(self.tableDriver)
    
    private let tableObservable: Observable<[StationsViewModel.TableContent]>
    
    init() {
        self.tableObservable = self.search
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { searchString in !searchString.isEmpty }
            .flatMapLatest { searchString in StopsAPIService.search(withName: searchString) }
            .map { stations in stations.map { s in StationsViewModel.TableContent.StationRow(s) } }
    }
    
    func stationsDriver(error: Error? = nil) -> Driver<[StationsViewModel.TableContent]> {
        if let err = error {
            return [Driver.just([StationsViewModel.TableContent.ErrorRow(err)]),
                    stationsDriver()].concat()
        }
        return tableObservable.asDriver(onErrorRecover: stationsDriver)
    }
}
