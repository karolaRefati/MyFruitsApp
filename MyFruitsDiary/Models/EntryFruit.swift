//
//  EntryFruit.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import Foundation

struct EntryFruit {
    var fruitId: Int?
    var fruitType: String?
    var amount: Int?
    
    init(json: [String: AnyObject]) {
        self.fruitId = json["fruitId"] as? Int
        self.fruitType = json["fruitType"] as? String
        self.amount = json["amount"] as? Int
    }
}
