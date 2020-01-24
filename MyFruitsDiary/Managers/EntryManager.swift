//
//  APIManager.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import UIKit

typealias EntryData = (([Entry]?, ServerError?) -> ())
typealias NetworkResponse = (([String: Any]?, ServerError?) -> ())
typealias FruitsData = (([Fruit]?, ServerError?) -> ())

class EntryManager {
    
    static var shared = EntryManager()
    
    internal func getEntries(completion: @escaping EntryData) {
        let urlString: String = Endpoints.shared.baseURL+Endpoints.shared.getEntriesEndpoint
        var entries = [Entry]()
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] {
                    for data in dataJSON {
                        let entry = Entry(json: data)
                        entries.append(entry)
                    }
                    completion(entries, nil)
                }
            } catch {
                
            }
        }
        task.resume()
    }
    
    internal func getFruit(completion: @escaping FruitsData) {
        let urlString: String = Endpoints.shared.baseURL+Endpoints.shared.getFruitEndpoint
        var fruit = [Fruit]()
        
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String: AnyObject]] {
                    for data in dataJSON {
                        let entry = Fruit(json: data)
                        fruit.append(entry)
                    }
                    completion(fruit, nil)
                }
            } catch {
                
            }
        }
        task.resume()
    }
    
    internal func deleteEntries() {
        let url:String = Endpoints.shared.baseURL+Endpoints.shared.getEntriesEndpoint
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    internal func deleteEntry(entryId: Int) {
        let url:String = Endpoints.shared.baseURL+Endpoints.shared.deleteEntryEndpoint+"/\(entryId)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    internal func addEntry(date: String) {
        let url:String = Endpoints.shared.baseURL+Endpoints.shared.getEntriesEndpoint
        
        let parameters = "{\n    \"date\": \"\(date)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    internal func editEntry(entryId: Int, fruitId: Int, nrOfFruit: Int) {
        let url:String = Endpoints.shared.baseURL+Endpoints.shared.deleteEntryEndpoint+"/\(entryId)"+Endpoints.shared.getFruitEndpoint+"/\(fruitId)"+"?amount=\(nrOfFruit)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
}

