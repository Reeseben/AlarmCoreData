//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Ben Erekson on 7/29/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    
    

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Properties
    var alarm: Alarm?
    var alarmIsOn = true
    
    
    //MARK: - Actions
    @IBAction func alarmIsEnabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
            alarmIsOn = alarm.isEnabled
        } else {
            alarmIsOn.toggle()
        }
        designIsEnabled()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text, !title.isEmpty else { return }
        if let alarm = alarm {
            AlarmController.shared.updateAlarm(alarm: alarm, newTitle: title, newFireDate: alarmFireDatePicker.date, isEnabled: alarmIsOn)
        } else {
            AlarmController.shared.createAlarm(withTitle: title, and: alarmFireDatePicker.date, and: alarmIsOn)        }
        navigationController.self?.popViewController(animated: true)
    }
    
    //MARK: - Helper Methods
    
    func updateViews(){
        guard let alarm = alarm,
              let date = alarm.fireDate else { return }
        
        alarmFireDatePicker.date = date
        alarmTitleTextField.text = alarm.title
        alarmIsOn = alarm.isEnabled
        designIsEnabled()
    }
    
    func designIsEnabled(){
        switch alarmIsOn {
        case true:
            alarmIsEnabledButton.backgroundColor = .white
            alarmIsEnabledButton.setTitle("Alarm is On", for: .normal)
        case false:
            alarmIsEnabledButton.backgroundColor = .darkGray
            alarmIsEnabledButton.setTitle("Alarm is Off", for: .normal)
        }
    }
    

}
