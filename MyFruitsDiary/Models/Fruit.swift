//
//  Fruit.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import Foundation

struct Fruit {
    var id: Int?
    var type: String?
    var vitamins: Int?
    var image: String?
    
    init(json: [String: AnyObject]) {
        self.id = json["id"] as? Int
        self.type = json["type"] as? String
        self.vitamins = json["vitamins"] as? Int
        self.image = json["image"] as? String
    }
}
