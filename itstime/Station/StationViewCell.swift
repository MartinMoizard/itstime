//
//  StationViewCell.swift
//  itstime
//
//  Created by Martin Moizard on 18/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class StationViewCell: UITableViewCell, ComponentView {
    @IBOutlet var name: UILabel!
    
    static let reusableIdentifier = "StationViewCell"
    
    func bind(to viewModel: ComponentViewModel) {
        guard let viewModel = viewModel as? StationViewModel else {
            fatalError("Expected viewModel of type StationViewModel")
        }
        self.disposeBag = DisposeBag()
        viewModel.name.map { Optional.some($0) }.bindTo(name.rx.text).addDisposableTo(self.disposeBag!)
    }
    
    func unbind(from viewModel: ComponentViewModel) {
        self.disposeBag = nil
    }
}
