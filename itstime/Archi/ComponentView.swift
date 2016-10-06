//
//  ComponentView.swift
//  itstime
//
//  Created by Martin Moizard on 04/10/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import RxSwift

protocol ComponentView: class {
    var disposeBag: DisposeBag? { get set }
    func bind(to viewModel: ComponentViewModel)
    func unbind(from viewModel: ComponentViewModel)
}

var disposeBagAttr = "disposeBagAttr"

extension ComponentView {
    var disposeBag: DisposeBag? {
        get {
            return objc_getAssociatedObject(self, &disposeBagAttr) as? DisposeBag
        }
        set {
             objc_setAssociatedObject(self, &disposeBagAttr, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
