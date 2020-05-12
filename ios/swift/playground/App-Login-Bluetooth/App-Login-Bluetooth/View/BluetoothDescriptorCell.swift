//
//  BluetoothDescriptorCell.swift
//  App-Login-Bluetooth
//
//  Created by George Sun on 5/3/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import UIKit

class BluetoothDescriptorCell: UITableViewCell {

    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var charLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
