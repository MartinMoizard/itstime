//
//  Error.swift
//  itstime
//
//  Created by Martin Moizard on 18/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import UIKit

extension NSError {
    static func timeForAnError(_ localizedError: String) -> NSError {
        return NSError(domain: "com.martinmoizard",
                       code: 1,
                       userInfo: [NSLocalizedDescriptionKey: localizedError])
    }
}
