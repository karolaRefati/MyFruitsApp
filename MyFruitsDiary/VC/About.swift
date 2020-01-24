//
//  About.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import UIKit
import Kingfisher

class About: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var fruitArray = [Fruit]()
    var currentFruit: Fruit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "About"
        tableview.dataSource = self
        tableview.delegate = self
        loadData()
    }
    
    func loadData(){
        EntryManager.shared.getFruit { (entryFruit, error) in
            if let entryFruit = entryFruit, error == nil {
                self.fruitArray = entryFruit
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            } else {
                print(String(describing: error))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fruitCell", for: indexPath) as! AboutCell
        currentFruit = fruitArray[indexPath.row]
        if let current = currentFruit{
            let fullimage = "\(current.image ?? "")"
            let urlString: String = Endpoints.shared.getFruitImage+"\(fullimage)"
            let url = URL(string: urlString)
            cell.fruitImage.kf.setImage(with: url)
            cell.fruitType.text = "\(current.type ?? "")"
            cell.vitamins.text = "Vitamins: \(current.vitamins ?? 0)"
        }
        return cell
    }
    
}
