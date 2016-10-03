//
//  ErrorViewCell.swift
//  itstime
//
//  Created by Martin MOIZARD-LANVIN on 20/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit

class ErrorViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    
    static let reusableIdentifier = "ErrorViewCell"
    
    func bind(withError error: NSError) {
        self.label.text = error.localizedDescription
    }
}
