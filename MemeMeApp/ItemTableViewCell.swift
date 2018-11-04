//
//  ItemTableViewCell.swift
//  MemeMeApp
//
//  Created by MajidHws on 10/31/18.
//  Copyright © 2018 MajidHws. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
