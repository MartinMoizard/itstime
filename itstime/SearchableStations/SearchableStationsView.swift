//
//  SearchableStationsView.swift
//  itstime
//
//  Created by Martin MOIZARD-LANVIN on 19/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchableStationsView: UIView, ComponentView {
    @IBOutlet var searchField: ProgressSearchBar!
    @IBOutlet var stationTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var stationsView: StationsView!
    
    func bind(to viewModel: ComponentViewModel) {
        guard let viewModel = viewModel as? SearchableStationsViewModel else {
            fatalError("Expected viewModel of type SearchableStationsViewModel")
        }
        
        self.disposeBag = DisposeBag()
        self.stationsView.bind(to: viewModel.stationsViewModel)
        self.stationsView.rx.contentOffset.subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.stationsViewDidScroll()
        }).addDisposableTo(disposeBag!)
        
        searchField.rx.text.bindTo(viewModel.search).addDisposableTo(disposeBag!)
        searchField.rx.searchButtonClicked.subscribe(onNext: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.searchButtonTapped()
        }).addDisposableTo(disposeBag!)
        stationTypeSegmentedControl.rx.value.bindTo(viewModel.searchType).addDisposableTo(disposeBag!)
        
        viewModel.searching.asDriver().drive(onNext: { [weak self] loading in
            guard let strongSelf = self else { return }
            strongSelf.toggleProgress(loading)
        }).addDisposableTo(disposeBag!)
    }
    
    func unbind(from viewModel: ComponentViewModel) {
        self.disposeBag = nil
    }
    
    fileprivate func toggleProgress(_ loading: Bool) {
        if loading {
            self.searchField.setProgress(progress: 80, withDuration: 4)
        } else if self.searchField.progress > 0 {
            self.searchField.setProgress(progress: 100, withDuration: 0.25)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.30, execute: {
                self.searchField.progress = 0
            })
        }
    }
    
    fileprivate func searchButtonTapped() {
        self.endEditing(true)
    }
    
    fileprivate func stationsViewDidScroll() {
        self.endEditing(true)
    }
}
