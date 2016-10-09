//
//  AppCoordinator.swift
//  itstime
//
//  Created by Martin Moizard on 17/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa

final class AppCoordinator : Coordinator {
    let window: UIWindow
    let rootViewController: UITabBarController
    let childCoordinators: NSMutableArray
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UITabBarController()
        self.rootViewController.tabBar.isTranslucent = false
        self.childCoordinators = NSMutableArray()
        
        setupTabBar()
        
        self.window.backgroundColor = UIColor.white
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func setupTabBar() {
        let favoriteNavigationController = UINavigationController()
        favoriteNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: 0)
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.search, tag: 1)
        
        self.rootViewController.viewControllers = [favoriteNavigationController, searchNavigationController]
        
        let favCoordiantor = FavoritesCoordinator(rootViewController: favoriteNavigationController)
        favCoordiantor.start()
        childCoordinators.add(favCoordiantor)
        
        let searchCoordinator = SearchCoordinator(rootViewController: searchNavigationController)
        searchCoordinator.start()
        childCoordinators.add(searchCoordinator)
    }
    
    func start() {
        self.rootViewController.selectedIndex = 1
    }
    
    func transition(toViewModel viewModel: ComponentViewModel, intent: SceneTransitionIntent) {
        
    }
}
