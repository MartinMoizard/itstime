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
import enum Result.Result

class SearchableStationsViewModel {
    let stationsViewModel: StationsViewModel
    let stations: Observable<Result<[Station], NSError>>
    let search: PublishSubject<String> = PublishSubject<String>()
    
    private var disposeBag = DisposeBag()
   
    init() {
        self.stations = self.search
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { searchString in !searchString.isEmpty }
            .flatMapLatest { (searchString) -> Observable<Result<[Station], NSError>> in
                return Observable.create { observer in
                    _ = StopsAPIService.search(withName: searchString).then { stops -> () in
                        observer.onNext(Result.success(stops))
                        observer.onCompleted()
                    }.catch { error in
                        observer.onNext(Result.failure(error as NSError))
                    }
                    return Disposables.create()
                }
            .shareReplay(1)
        }
        
        self.stationsViewModel = StationsViewModel(self.stations)
    }
}
