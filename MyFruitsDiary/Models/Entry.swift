//
//  Entry.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import Foundation

struct Entry {
    var id: Int?
    var date: String?
    var fruit: [EntryFruit]?
    
    init(json: [String: AnyObject]) {
        self.id = json["id"] as? Int
        self.date = json["date"] as? String
        self.fruit = []
        if let fruits = json["fruit"] as? [[String: AnyObject]] {
            for fruit in fruits {
                let fruit = EntryFruit(json: fruit)
                self.fruit?.append(fruit)
            }
        }
    }
}
