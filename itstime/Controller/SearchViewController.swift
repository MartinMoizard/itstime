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
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let view = self.view as! SearchableStationsView
        view.bind(with: SearchableStationsViewModel())
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension SearchViewController: UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
      self.view.endEditing(true)
    }
}