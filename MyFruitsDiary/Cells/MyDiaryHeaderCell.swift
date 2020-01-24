//
//  MyDiaryHeaderCell.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import UIKit

class MyDiaryHeaderCell: UITableViewCell {
    
    @IBOutlet weak var entry: UILabel!
    @IBOutlet weak var fruit: UILabel!
    @IBOutlet weak var vitamins: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
