//
//  ComponentViewController.swift
//  itstime
//
//  Created by Martin Moizard on 04/10/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit

protocol ComponentController {
    var coordinator: Coordinator? { get set }
    var componentView: ComponentView? { get }
    var viewModel: ComponentViewModel! { get set }
}

extension ComponentController {
    func makeBindings() {
        guard let viewModel = self.viewModel, let componentView = self.componentView else {
            return
        }
        componentView.bind(to: viewModel)
    }
    
    func destroyBindings() {
        guard let viewModel = self.viewModel, let componentView = self.componentView else {
            return
        }
        componentView.unbind(from: viewModel)
    }
}

class ComponentViewController : UIViewController, ComponentController {
    private var shouldMakeBinding = false
    
    var coordinator: Coordinator?
    
    var viewModel: ComponentViewModel! {
        didSet {
            if shouldMakeBinding {
                self.didSetViewModel()
            }
        }
    }
    
    var componentView: ComponentView? {
        get {
            return self.isViewLoaded ? self.view as? ComponentView : nil
        }
    }
    
    func didSetViewModel() {
        self.destroyBindings()
        self.makeBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.shouldMakeBinding = true
        self.makeBindings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.destroyBindings()
        self.shouldMakeBinding = false
    }
}
