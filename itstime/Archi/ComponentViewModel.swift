//
//  ViewModelType.swift
//  itstime
//
//  Created by Martin Moizard on 04/10/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

protocol ViewModelType {
    var coordinator: Coordinator { get }
}

class ComponentViewModel : ViewModelType {
    let coordinator: Coordinator
    
    init(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}
