//
//  EditEntryCell.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import UIKit

class EditEntryCell: UITableViewCell {

    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var fruitType: UILabel!
    @IBOutlet weak var fruitVitamins: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
