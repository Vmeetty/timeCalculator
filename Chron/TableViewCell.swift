//
//  TableViewCell.swift
//  Chron
//
//  Created by vlad on 09.05.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

protocol SaveDelegate {
    func update()
}

class TableViewCell: UITableViewCell {
    
    var delegate: SaveDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    let hoursTitles = TableViewCell.getHoursTitles()
    let minutesTitles = TableViewCell.getMinsOrSecondsTitles()
    let secondsTitles = TableViewCell.getMinsOrSecondsTitles()
    var hours = 0
    var mins = 0
    var seconds = 0
    
    var time: TimeModel! {
        didSet {
            configCell()
        }
    }
    
    func configCell () {
        createToolBar()
        textField.inputView = createDatePicker()
        textField.text = time.title()
        textField.becomeFirstResponder()
    }
    
    func createToolBar () {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Hide picker", style: .plain, target: self, action: #selector(donePressed(view:)))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    func donePressed (view: UIView) {
        let timeObj = TimeModel(hours: hours, minutes: mins, seconds: seconds)
        time.seconds = timeObj.seconds
        configCell()
        textField.resignFirstResponder()
    }
   
    private func createDatePicker () -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        return picker
    }

    static func getHoursTitles () -> [String] {
        var hoursTitles = [String]()
        for count in 0...24 {
            hoursTitles.append("\(count)")
        }
        return hoursTitles
    }
    static func getMinsOrSecondsTitles () -> [String] {
        var mins = [String]()
        for count in 0...60 {
            mins.append("\(count)")
        }
        return mins
    }
    
}

extension TableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return hoursTitles.count
        case 1: return minutesTitles.count
        case 2: return secondsTitles.count
        default: return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return hoursTitles[row]
        case 1: return minutesTitles[row]
        case 2: return secondsTitles[row]
        default: return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: hours = Int(hoursTitles[row])!
        case 1: mins = Int(minutesTitles[row])!
        case 2: seconds = Int(secondsTitles[row])!
        default: break
        }
        time.seconds = time.toSeconds(hours: hours, minutes: mins, seconds: seconds)
        configCell()
        delegate?.update()
        
    }
}







