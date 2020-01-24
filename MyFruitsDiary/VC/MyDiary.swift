//
//  MyDiary.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import UIKit

class MyDiary: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var entryArray =  [Entry]()
    var fruitArray = [Fruit]()
    
    var currentEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonAdd = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addEntry))
        let buttonDelete = UIBarButtonItem(title: "Delete all", style: .plain, target: self, action: #selector(deleteAll))
        self.navigationItem.leftBarButtonItem = buttonDelete
        navigationItem.rightBarButtonItem = buttonAdd
        navigationItem.title = "My diary"
        
        tableView.dataSource = self
        tableView.delegate = self
        getFruit()
    }
    
    func loadData() {
        EntryManager.shared.getEntries { (entryData, error) in
            if let entryData = entryData, error == nil {
                self.entryArray = entryData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print(String(describing: error))
            }
        }
    }
    
    func getFruit(){
        EntryManager.shared.getFruit { (fruitData, error) in
            if let fruitData = fruitData, error == nil {
                self.fruitArray = fruitData
                self.loadData()
            } else {
                print(String(describing: error))
            }
        }
    }
    
    @objc func addEntry(){
        performSegue(withIdentifier: "segueEntry", sender: self)
    }
    
    @objc func deleteAll(){
        EntryManager.shared.deleteEntries()
        loadData()
    }
    
    private func calculateAllVitamins(fruitsForEntry: [EntryFruit]?) -> Int? {
        var vitaminsCounter = 0
        if let fruitsForEntry = fruitsForEntry {
            for fruitEntry in fruitsForEntry {
                for fruit in fruitArray {
                    if fruit.id == fruitEntry.fruitId {
                        if let fruitNumber = fruitEntry.amount, let vitamins = fruit.vitamins {
                            vitaminsCounter += fruitNumber * vitamins
                        }
                    }
                }
            }
        }
        return vitaminsCounter
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "mydiarycellHeader") as! MyDiaryHeaderCell
        header.entry.text = "ENTRY"
        header.fruit.text = "FRUITS"
        header.vitamins.text = "VITAMINS"
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mydiarycell", for: indexPath) as! MyDiaryCell
        currentEntry = entryArray[indexPath.row]
        if let current = currentEntry{
            cell.entryLabel.text = "\(current.id ?? 0)"
            cell.fruitLabel.text = "\(current.fruit?.count ?? 0)"
            let allVitamins = calculateAllVitamins(fruitsForEntry: current.fruit)
            cell.vitaminsLabel.text = "\(allVitamins ?? 0)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueEdit", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let data = entryArray[indexPath.row].id{
                EntryManager.shared.deleteEntry(entryId: data)
            }
            entryArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EditEntryVC {
            if let data =  currentEntry{
                vc.entry = data
            }
        }
    }
    
}
