//
//  EditEntryVC.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import UIKit
import Kingfisher

class EditEntryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nrFruits: UITextField!
    @IBOutlet weak var nrFruitsLabel: UILabel!
    var fruitArray = [Fruit]()
    var entryArray = [Entry]()
    var entry: Entry?
    var fruit: Fruit?
    var fruitId: Int = 0
    var entryid: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let entryId = entry?.id{
            navigationItem.title = "Entry \(String(describing: entryId))"
        }
        let buttonSave = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = buttonSave
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(selectDate), for: .valueChanged)
        if let entryDate = entry?.date{
            dateLabel.text = String(describing: entryDate)
        }
        dateLabel.textAlignment =  .center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        nrFruits.keyboardType = .decimalPad
        nrFruitsLabel.isHidden = true
        nrFruits.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadFruits()
    }
    
    @objc func selectDate()  {
        datePicker.maximumDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = dateFormatter.string(from: (datePicker?.date)!)
        dateLabel.resignFirstResponder()
    }
    
    func loadFruits() {
        EntryManager.shared.getFruit { (fruitData, error) in
            if let fruitData = fruitData, error == nil{
                self.fruitArray = fruitData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else {
                print(String(describing: error))
            }
        }
    }
    
    @objc func save(){
        let nrOfFruits = (nrFruits.text! as NSString).integerValue
        if let entryId = entry?.id, nrOfFruits != 0{
            navigationItem.title = "Entry \(String(describing: entryId))"
            EntryManager.shared.editEntry(entryId: entryId, fruitId: fruitId, nrOfFruit: nrOfFruits)
        }
        
        performSegue(withIdentifier: "backDiary", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editEntryCell", for: indexPath) as! EditEntryCell
        if let data = fruitArray[indexPath.row].id{
            fruitId = data
        }
        fruit = fruitArray[indexPath.row]
        if let current = fruit{
            let fullimage = "\(current.image ?? "")"
            let urlString: String = Endpoints.shared.getFruitImage+"\(fullimage)"
            let url = URL(string: urlString)
            cell.fruitImage.kf.setImage(with: url)
            cell.fruitType.text = "\(current.type ?? "")"
            cell.fruitVitamins.text = "Vitamins: \(current.vitamins ?? 0)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fruitId = fruitArray[indexPath.row].id!
        nrFruitsLabel.isHidden = false
        nrFruits.isHidden = false
    }
    
    
}
