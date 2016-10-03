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

class SearchableStationsView: UIView {
    @IBOutlet var searchField: ProgressSearchBar!
    @IBOutlet var stationTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var stationsView: StationsView!
    
    private var viewModel: SearchableStationsViewModel!
    private var disposeBag: DisposeBag?
   
    func bind(with viewModel: SearchableStationsViewModel) {
        self.disposeBag = DisposeBag()
        if let disposeBag = self.disposeBag {
            self.viewModel = viewModel
            self.stationsView.bind(with: self.viewModel.stationsViewModel)
            self.stationsView.rx.contentOffset.subscribe(onNext: { [weak self] _ in self?.stationsViewDidScroll() }).addDisposableTo(disposeBag)
            
            searchField.rx.text.bindTo(viewModel.search).addDisposableTo(disposeBag)
            searchField.rx.searchButtonClicked.subscribe(onNext: { [weak self] in self?.searchButtonTapped() }).addDisposableTo(disposeBag)
            stationTypeSegmentedControl.rx.value.bindTo(viewModel.searchType).addDisposableTo(disposeBag)
            
            self.viewModel.searching.asDriver().drive(onNext: { [weak self] loading in self?.toggleProgress(loading)}).addDisposableTo(disposeBag)
        }
    }
    
    func unbind() {
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
