//
//  StationsView.swift
//  itstime
//
//  Created by Martin Moizard on 18/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class StationsView: UITableView {
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        self.register(UINib(nibName: "StationViewCell", bundle: nil), forCellReuseIdentifier: StationViewCell.reusableIdentifier)
    }
    
    func bind(with viewModel: StationsViewModel) {
        viewModel.stations.bindTo(self.rx.items(cellIdentifier: StationViewCell.reusableIdentifier, cellType: StationViewCell.self)) { (row, element, cell) in
            cell.bind(with: StationViewModel(element))
        }.addDisposableTo(disposeBag)
    }
}
