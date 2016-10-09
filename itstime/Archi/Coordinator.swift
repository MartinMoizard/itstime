//
//  Coordinator.swift
//  itstime
//
//  Created by Martin Moizard on 04/10/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
    func transition(toViewModel viewModel: ComponentViewModel, intent: SceneTransitionIntent)
}

struct SceneTransitionIntent {
    enum TransitionMethod {
        case push
        case modal
    }
    
    enum Controller {
        case named(String)
        case ofType(UIViewController.Type)
        
        func instanciate() -> UIViewController {
            switch self {
            case .named(let controllerIdentifier):
                let aClass = NSClassFromString(controllerIdentifier) as! UIViewController.Type
                return aClass.init()
            case .ofType(let type):
                return type.init()
            }
        }
    }
    
    let transitionMethod: TransitionMethod
    let controller: Controller
    
    init(with method: TransitionMethod, to aController: Controller) {
        transitionMethod = method
        controller = aController
    }
}

class EmptyCoordinator: Coordinator {
    func start() {}
    func transition(toViewModel viewModel: ComponentViewModel, intent: SceneTransitionIntent) {}
}
