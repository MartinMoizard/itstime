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

class StationsView: UITableView, ComponentView {
    
    override func awakeFromNib() {
        self.register(UINib(nibName: "StationViewCell", bundle: nil), forCellReuseIdentifier: StationViewCell.reusableIdentifier)
        self.register(UINib(nibName: "ErrorViewCell", bundle: nil), forCellReuseIdentifier: ErrorViewCell.reusableIdentifier)
    }
    
    func bind(to viewModel: ComponentViewModel) {
        guard let viewModel = viewModel as? StationsViewModel else {
            fatalError("Expected viewModel of type StationsViewModel")
        }
        
        self.disposeBag = DisposeBag()
        
        viewModel.tableDriver.drive(self.rx.items) { (tableView, row, element) in
            switch element {
            case .stationRow(let station):
                let cell = tableView.dequeueReusableCell(withIdentifier: StationViewCell.reusableIdentifier) as! StationViewCell
                cell.bind(to: StationViewModel(withCoordinator: viewModel.coordinator, andStation: station))
                return cell
            case .errorRow(let error):
                let cell = tableView.dequeueReusableCell(withIdentifier: ErrorViewCell.reusableIdentifier) as! ErrorViewCell
                cell.bind(withError: error as NSError)
                return cell
            }
        }.addDisposableTo(disposeBag!)
        
        self.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let strongSelf = self else { return }
            let selectedModel: StationsViewModel.TableContent? = try? strongSelf.rx.model(indexPath)
            guard let model = selectedModel else { return }
            viewModel.showStation.execute(model)
        }).addDisposableTo(disposeBag!)
    }
    
    func unbind(from viewModel: ComponentViewModel) {
        self.disposeBag = nil
    }
}

