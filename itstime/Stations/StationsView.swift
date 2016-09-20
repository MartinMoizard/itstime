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
import enum Result.Result

class StationsView: UITableView {
    private var stationsDataSource = StationsDataSource()
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        self.register(UINib(nibName: "StationViewCell", bundle: nil), forCellReuseIdentifier: StationViewCell.reusableIdentifier)
        self.register(UINib(nibName: "ErrorViewCell", bundle: nil), forCellReuseIdentifier: ErrorViewCell.reusableIdentifier)
    }
    
    func bind(with viewModel: StationsViewModel) {
        viewModel.stations.bindTo(self.rx.items(dataSource: self.stationsDataSource)).addDisposableTo(disposeBag)
    }
}

class StationsDataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {
    typealias Element = Result<[Station], NSError>
    
    private var _result: Element = Result.success([])

    func tableView(_ tableView: UITableView, observedEvent: Event<Element>) -> Void {
        UIBindingObserver(UIElement: self) { dataSource, element in
            self._result = element
            tableView.reloadData()
        }.on(observedEvent)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._result.error != nil ? 1 : self._result.value!.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self._result {
        case .success(let stops):
            let cell = tableView.dequeueReusableCell(withIdentifier: StationViewCell.reusableIdentifier, for: indexPath) as! StationViewCell
            cell.bind(with: StationViewModel(stops[indexPath.row]))
            return cell
        case .failure(let error):
            let cell = tableView.dequeueReusableCell(withIdentifier: ErrorViewCell.reusableIdentifier, for: indexPath) as! ErrorViewCell
            cell.bind(withError: error)
            return cell
        }
    }
}
