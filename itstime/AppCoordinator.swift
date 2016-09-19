//
//  AppCoordinator.swift
//  itstime
//
//  Created by Martin Moizard on 17/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator : Coordinator {
    let window: UIWindow
    let rootViewController: UITabBarController
    let childCoordinators: NSMutableArray
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UITabBarController()
        self.childCoordinators = NSMutableArray()
        
        setupTabBar()
        
        self.window.backgroundColor = UIColor.white
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func setupTabBar() {
        let favVc = FavoritesViewController()
        favVc.delegate = self
        favVc.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: 0)
        
        let searchVc = SearchViewController()
        searchVc.delegate = self
        searchVc.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.search, tag: 1)
        
        self.rootViewController.viewControllers = [favVc, searchVc]
    }
    
    func start() {
        self.rootViewController.selectedIndex = 1
    }
}

extension AppCoordinator : CoordinatedViewControllerDelegate {
    func coordinatedViewControllerDidLoad(_ viewController: CoordinatedViewController) {
        if let searchVc = viewController as? SearchViewController {
            searchVc.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.rootViewController.tabBar.frame.height, 0)
        }
    }
}
