//
//  SearchAppCoordinator.swift
//  itstime
//
//  Created by Martin Moizard on 09/10/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit
import RxCocoa

final class SearchCoordinator : Coordinator {
    let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        rootViewController.navigationBar.isTranslucent = false
        let searchVc = SearchableStationsViewController()
        let viewModel = SearchableStationsViewModel(coordinator: self)
        searchVc.viewModel = viewModel
        searchVc.coordinator = self
        rootViewController.viewControllers = [searchVc]
    }
    
    func transition(toViewModel viewModel: ComponentViewModel, intent: SceneTransitionIntent) {
        self.rootViewController.pushViewController(intent.controller.instanciate(), animated: true)
    }
}
