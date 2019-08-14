//
//  WCCallActivityCell.swift
//  WorldChatters
//
//  Created by Sunil Garg on 24/07/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

class WCCallActivityCell: UITableViewCell {
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var callDurationLbl: UILabel!
    @IBOutlet var callTypeLbl: UILabel!
    @IBOutlet var costOfCallLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
