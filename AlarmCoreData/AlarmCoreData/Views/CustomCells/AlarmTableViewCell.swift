//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Ben Erekson on 7/29/21.
//

import UIKit

protocol AlarmTableViewCellDelegate: AnyObject {
    func AlarmWasToggled(sender: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var fireDateLable: UILabel!
    @IBOutlet weak var isOnSwitch: UISwitch!
    
    
    //MARK: - Properties
    weak var delegate: AlarmTableViewCellDelegate?
    var alarm: Alarm?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Helper Functions
    func updateVews(){
        guard let alarm = alarm else { return }
        titleLable.text = alarm.title
        fireDateLable.text = alarm.fireDate?.asString()
        isOnSwitch.isOn = alarm.isEnabled
    }
    
    //MARK: - Actions
    @IBAction func isEnabledToggled(_ sender: Any) {
        delegate?.AlarmWasToggled(sender: self)
    }
    
}
