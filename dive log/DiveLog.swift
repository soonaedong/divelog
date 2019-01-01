//
//  DiveLog.swift
//  dive log
//
//  Created by max on 01/01/2019.
//  Copyright © 2019 shc. All rights reserved.
//

import Foundation
import UIKit

class DiveLog {
    var site: String
    var date: Date
    var time: Date
    
    init?(site: String, date: Date, time: Date) {
        if site.isEmpty {
            return nil
        }
        
        self.site = site
        self.date = date
        self.time = time
        
    }
    
    
    
    
}
