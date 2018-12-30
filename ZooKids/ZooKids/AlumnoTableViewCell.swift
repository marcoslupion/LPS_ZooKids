//
//  AlumnoTableViewCell.swift
//  ZooKids
//
//  Created by Alberto Fuentes on 30/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class AlumnoTableViewCell: UITableViewCell {

    @IBOutlet weak var nombre: UILabel!

    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var fecha: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
