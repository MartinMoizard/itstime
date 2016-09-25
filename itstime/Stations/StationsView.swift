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
        self.register(UINib(nibName: "ErrorViewCell", bundle: nil), forCellReuseIdentifier: ErrorViewCell.reusableIdentifier)
    }
    
    func bind(with viewModel: StationsViewModel) {
        viewModel.tableObservable.bindTo(self.rx.items) { (tableView, row, element) in
            switch element {
            case .StationRow(let station):
                let cell = tableView.dequeueReusableCell(withIdentifier: StationViewCell.reusableIdentifier) as! StationViewCell
                cell.bind(with: StationViewModel(station))
                return cell
            case .ErrorRow(let error):
                let cell = tableView.dequeueReusableCell(withIdentifier: ErrorViewCell.reusableIdentifier) as! ErrorViewCell
                cell.bind(withError: error as NSError)
                return cell
            }
        }.addDisposableTo(disposeBag)
    }
}

