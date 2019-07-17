//
//  CategoriesTableViewCell.swift
//  WorldChatters
//
//  Created by Sunil Garg on 21/06/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

class WCCategoryCell: UITableViewCell {
    @IBOutlet var countBtn: JKButton!
    @IBOutlet var categoryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class WCReadersCell: UITableViewCell {
    @IBOutlet private var userImageView: JKImageView!
    @IBOutlet private var userNameLbl: UILabel!
    @IBOutlet private var userEmailLbl: UILabel!
    @IBOutlet private var viewUserBtn: JKButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var row:Int=0{
        didSet{
            viewUserBtn.tag = row 
        }
    }
    
    var model:WCReaderModel?{
        didSet{
            userNameLbl.text = model?.name ?? ""
            userEmailLbl.text = model?.email ?? ""
            
        }
    }
    

}
