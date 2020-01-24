//
//  Endpoints.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import Foundation

internal class Endpoints {
    static var shared = Endpoints()
    
    let baseURL = "https://fruitdiary.test.themobilelife.com/api"
    let getFruitEndpoint = "/fruit"
    let getEntriesEndpoint = "/entries"
    let deleteEntryEndpoint = "/entry"
    let getFruitImage = "https://fruitdiary.test.themobilelife.com/"
}
