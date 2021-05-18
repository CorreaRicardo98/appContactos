//
//  ContactTableViewCell.swift
//  appContactosCoreData
//
//  Created by Mac19 on 13/05/21.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreContacto: UILabel!
    @IBOutlet weak var telefonoContacto: UILabel!
    
    @IBOutlet weak var imagenContacto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
