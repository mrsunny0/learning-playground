//
//  MessageCell.swift
//  App-Login-Bluetooth
//
//  Created by George Sun on 5/2/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import UIKit

class DeviceCell: UITableViewCell {
    
    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var UUIDLabel: UILabel!
    @IBOutlet weak var RSSILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
