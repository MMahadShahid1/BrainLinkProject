//
//  AppointListTableViewCell.swift
//  BrainLink
//
//  Created by Muhammad Mahad on 2025-04-12.
//

import UIKit

class AppointListTableViewCell: UITableViewCell {
   
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var phoneLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var doctorLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
