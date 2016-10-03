//
//  SearchViewController.swift
//  itstime
//
//  Created by Martin Moizard on 17/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: CoordinatedViewController {
    @IBOutlet var tableView: UITableView!
    lazy private var searchableStationsView: SearchableStationsView = {
       return self.view as! SearchableStationsView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchableStationsView.bind(with: SearchableStationsViewModel())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.searchableStationsView.unbind()
    }
}
