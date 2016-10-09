//
//  LinesStationView.swift
//  itstime
//
//  Created by Martin Moizard on 09/10/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

class LinesStationView : UIView, ComponentView {
    func bind(to viewModel: ComponentViewModel) {
        
    }

    func unbind(from viewModel: ComponentViewModel) {
        self.disposeBag = nil
    }
}
