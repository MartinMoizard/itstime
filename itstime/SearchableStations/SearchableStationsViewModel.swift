//
//  SearchableStationsViewModel.swift
//  itstime
//
//  Created by Martin MOIZARD-LANVIN on 19/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import RxSwift

class SearchableStationsViewModel {
    let stationsViewModel: StationsViewModel
    let stations: Observable<[StationsViewModel.TableContent]>
    let search: PublishSubject<String> = PublishSubject<String>()
    
    private var disposeBag = DisposeBag()
   
    init() {
        self.stations = self.search
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { searchString in !searchString.isEmpty }
            .flatMapLatest { searchString in StopsAPIService.search(withName: searchString) }
            .map { stations in stations.map { s in StationsViewModel.TableContent.StationRow(s) } }
            .catchError { err in Observable.just([StationsViewModel.TableContent.ErrorRow(err)]) }
        
        self.stationsViewModel = StationsViewModel(self.stations)
    }
}
