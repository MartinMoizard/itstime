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
    @IBOutlet var searchField: UISearchBar!
    @IBOutlet var stationsView: StationsView!
    
    private var viewModel: SearchableStationsViewModel!
    private var disposeBag = DisposeBag()
   
    func bind(with viewModel: SearchableStationsViewModel) {
        self.viewModel = viewModel
        self.stationsView.bind(with: self.viewModel.stationsViewModel)
        searchField.rx.text.bindTo(viewModel.search).addDisposableTo(disposeBag)
    }
}
