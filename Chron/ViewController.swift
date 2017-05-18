//
//  ViewController.swift
//  Chron
//
//  Created by vlad on 09.05.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

let cellID = "myCell"

class ViewController: UIViewController {
  
    @IBOutlet var myTimePicker: UIPickerView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet weak var myTableView: UITableView!
    
    var timeCollection: [TimeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addBarButtonItem(_ sender: UIBarButtonItem) {
        let timeObj = TimeModel(inSeconds: 0)
        timeCollection.append(timeObj)
        let indexPath = IndexPath.init(row: timeCollection.count - 1, section: 0)
        self.myTableView.insertRows(at: [indexPath], with: .right)
        self.myTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
    }
    
    @IBAction func editBarButtonItem(_ sender: UIBarButtonItem) {
        self.myTableView.isEditing = !self.myTableView.isEditing
        sender.title = self.myTableView.isEditing ? "Cancel" : "Delete"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        timeCollection.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell
        cell.time = timeCollection[indexPath.row]
        cell.delegate = self
        
        return cell
    }

}

extension ViewController: SaveDelegate {
    func update() {
        let seconds = TimeModel.calculateOverallSeconds(times: timeCollection)
        let sumTimes = TimeModel.updateResult(seconds: seconds)
        let label = UILabel()
        label.text = sumTimes
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        myTableView.tableFooterView = label
    }
}













