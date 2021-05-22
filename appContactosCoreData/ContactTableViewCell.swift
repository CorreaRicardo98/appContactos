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
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imagenContacto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.masksToBounds = false
        backView.layer.cornerRadius = 9
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.5
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
