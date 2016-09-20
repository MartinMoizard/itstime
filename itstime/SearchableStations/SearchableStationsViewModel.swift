//
//  SearchableStationsViewModel.swift
//  itstime
//
//  Created by Martin MOIZARD-LANVIN on 19/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import PromiseKit
import RxSwift

class SearchableStationsViewModel {
    let stationsViewModel: StationsViewModel
    let stations: Observable<[Station]>
    let search: PublishSubject<String> = PublishSubject<String>()
    
    private var disposeBag = DisposeBag()
   
    init() {
        self.stations = self.search
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { searchString in !searchString.isEmpty }
            .flatMapLatest { searchString in
                return Observable.create { observer in
                    _ = StopsAPIService.search(withName: searchString).then { stops -> () in
                        observer.onNext(stops)
                        observer.onCompleted()
                    }.catch { error in
                        observer.onError(error)
                    }
                    return Disposables.create()
                }
        }
        self.stationsViewModel = StationsViewModel(self.stations)
    }
}
