//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by Ben Erekson on 7/29/21.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        AlarmController.shared.fetchAlarms()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell()}
        
        cell.delegate = self
        cell.alarm = AlarmController.shared.alarms[indexPath.row]
        cell.updateVews()

        return cell
    }
 


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToDetail" {
            guard let destination = segue.destination as? AlarmDetailTableViewController,
                  let index = tableView.indexPathForSelectedRow else { return }
            let alarm = AlarmController.shared.alarms[index.row]
            destination.alarm = alarm
        }
    }


}

extension AlarmListTableViewController: AlarmTableViewCellDelegate {
    func AlarmWasToggled(sender: AlarmTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        let alarm = AlarmController.shared.alarms[index.row]
        AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
        tableView.reloadData()
    }
    
    
}
