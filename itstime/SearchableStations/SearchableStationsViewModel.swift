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
    let searching = ActivityIndicator()
    lazy var tableDriver: Driver<[StationsViewModel.TableContent]> = self.stationsDriver()
    lazy var stationsViewModel: StationsViewModel = StationsViewModel(self.tableDriver)
    
    private var tableObservable: Observable<[StationsViewModel.TableContent]> = Observable.empty()
    
    init() {
        self.tableObservable = self.search
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { searchString in !searchString.isEmpty }
            .flatMapLatest { [unowned self] searchString in StopsAPIService.search(withName: searchString).trackActivity(self.searching) }
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
