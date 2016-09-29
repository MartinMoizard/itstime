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

class StationViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    
    static let reusableIdentifier = "StationViewCell"
    
    private var disposeBag: DisposeBag?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(with viewModel: StationViewModel) {
        self.disposeBag = DisposeBag()
        if let disposeBag = self.disposeBag {
            viewModel.name.map{ Optional.some($0) }.bindTo(name.rx.text).addDisposableTo(disposeBag)
        }
    }
    
    func unbind() {
        self.disposeBag = nil
    }
}
