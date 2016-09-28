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
    @IBOutlet var stationsView: StationsView!
    
    private var viewModel: SearchableStationsViewModel!
    private var disposeBag = DisposeBag()
   
    func bind(with viewModel: SearchableStationsViewModel) {
        self.viewModel = viewModel
        self.stationsView.bind(with: self.viewModel.stationsViewModel)
        searchField.rx.text.bindTo(viewModel.search).addDisposableTo(disposeBag)
        self.viewModel.searching.asDriver().drive(onNext: { [unowned self] loading in self.toggleProgress(loading)}).addDisposableTo(disposeBag)
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
}
