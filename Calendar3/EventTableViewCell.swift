//
//  EventTableViewCell.swift
//  Calendar3
//
//  Created by Sunil Gurung on 5/23/17.
//  Copyright © 2017 Impactit. All rights reserved.
//

import UIKit
import CoreData
class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var lblnote: UILabel!
    @IBOutlet weak var lblsubject: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
