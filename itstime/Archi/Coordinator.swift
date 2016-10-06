//
//  Coordinator.swift
//  itstime
//
//  Created by Martin Moizard on 04/10/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

protocol Coordinator {
    func start()
    func transition(toViewModel viewModel: ComponentViewModel)
}

class EmptyCoordinator: Coordinator {
    func start() {}
    func transition(toViewModel viewModel: ComponentViewModel) {}
}
