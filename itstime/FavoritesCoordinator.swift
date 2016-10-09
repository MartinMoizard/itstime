//
//  FavoritesCoordinator.swift
//  itstime
//
//  Created by Martin Moizard on 09/10/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit

final class FavoritesCoordinator : Coordinator {
    let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let favVc = FavoritesViewController()
        rootViewController.viewControllers = [favVc]
    }
    
    func transition(toViewModel viewModel: ComponentViewModel, intent: SceneTransitionIntent) {
        
    }
}
