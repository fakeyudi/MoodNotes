//
//  SettingsTableViewCell.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 28/7/21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var hapticSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(for option: SettingsOption){
        iconImage.image = option.icon
        nameLabel.text = option.name
        hapticSwitch.isHidden = !(option.name == "Haptics")
        chevronImage.isHidden = (option.name == "Haptics")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
