//
//  DiveLogTableViewCell.swift
//  dive log
//
//  Created by max on 01/01/2019.
//  Copyright © 2019 shc. All rights reserved.
//

import UIKit

class DiveLogTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var diveDate: UILabel!
    @IBOutlet weak var diveTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
