//
//  ProgressSearchBar.swift
//  itstime
//
//  Created by Martin MOIZARD-LANVIN on 20/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit
import CoreGraphics
import Progressable

class ProgressSearchBar: UISearchBar, Progressable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initProgress()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initProgress()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutProgress()
    }
}
