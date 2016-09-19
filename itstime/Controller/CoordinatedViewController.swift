//
//  CoordinatedViewController.swift
//  itstime
//
//  Created by Martin Moizard on 19/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatedViewControllerDelegate : class {
    func coordinatedViewControllerDidLoad(_ viewController: CoordinatedViewController)
}

class CoordinatedViewController : UIViewController {
    weak var delegate: CoordinatedViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate?.coordinatedViewControllerDidLoad(self)
    }
}
