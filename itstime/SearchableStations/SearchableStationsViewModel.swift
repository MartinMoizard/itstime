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

class SearchableStationsViewModel : ComponentViewModel {
    enum SearchType: Int {
        case railroad = 0
        case bus = 1
    }
    
    private(set) var stationsViewModel: StationsViewModel = StationsViewModel(withCoordinator: EmptyCoordinator(), andTableDriver: Driver.empty())
    
    // Input
    let searching = ActivityIndicator()
    private(set) var tableDriver: Driver<[StationsViewModel.TableContent]> = Driver.empty()
    
    // Output
    let search: PublishSubject<String> = PublishSubject<String>()
    let searchType: PublishSubject<Int> = PublishSubject<Int>()
    
    // Private
    private var allStationsObservable: Observable<[StationsViewModel.TableContent]> = Observable.empty()
    private var filteredStationsObservable: Observable<[StationsViewModel.TableContent]> = Observable.empty()
    
    init(coordinator: Coordinator) {
        super.init(coordinator)
        
        self.allStationsObservable = self.search
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { searchString in !searchString.isEmpty }
            .flatMapLatest { [weak self] searchString -> Observable<[Station]> in
                guard let strongSelf = self else { return Observable.empty() }
                return StopsAPIService.search(withName: searchString).trackActivity(strongSelf.searching)
            }
            .map { stations in stations.map { s in StationsViewModel.TableContent.stationRow(s) } }
        
        self.filteredStationsObservable = Observable
            .combineLatest(self.allStationsObservable, self.searchType, resultSelector: { tableContent, searchType in
                return (tableContent, SearchType(rawValue: searchType) ?? .railroad)
            })
            .map { (rows, type) in
                return rows.filter { row in
                    switch row {
                    case .stationRow(let station):
                        return station.lines.contains(where: { line in line.matches(searchType: type) })
                    case .errorRow(_):
                        return true
                    }
                }
            }
        
        self.tableDriver = self.stationsDriver()
        
        self.stationsViewModel = StationsViewModel(withCoordinator: coordinator, andTableDriver: self.tableDriver)
    }
    
    func stationsDriver(error: Error? = nil) -> Driver<[StationsViewModel.TableContent]> {
        if let err = error {
            return [Driver.just([StationsViewModel.TableContent.errorRow(err)]),
                    stationsDriver()].concat()
        }
        return filteredStationsObservable.asDriver(onErrorRecover: stationsDriver)
    }
}

extension Line {
    fileprivate func matches(searchType: SearchableStationsViewModel.SearchType) -> Bool {
        switch searchType {
        case .railroad:
            return mode == .metro || mode == .rail || mode == .tram
        case .bus:
            return mode == .bus || mode == .noctilien
        }
    }
}
