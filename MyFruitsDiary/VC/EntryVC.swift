//
//  EntryVC.swift
//  MyFruitsDiary
//
//  Created by Karola Refati
//  Copyright © 2020 Karola Refati. All rights reserved.
//

import UIKit

class EntryVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var totVitamins = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonSave = UIBarButtonItem(title: "Add entry", style: .plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = buttonSave
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(selectDate), for: .valueChanged)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = formatter.string(from: Date())
        dateLabel.textAlignment =  .center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
    }
    
    @objc func selectDate()  {
        datePicker.maximumDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = dateFormatter.string(from: (datePicker?.date)!)
        dateLabel.resignFirstResponder()
    }
    
    @objc func save(){
        EntryManager.shared.addEntry(date: dateLabel.text!)
        performSegue(withIdentifier: "backDiaryAdd", sender: self)
    }
    
    
}
