//
//  PaymentCell.swift
//  Wine
//
//  Created by Apple on 02/08/21.
//

import UIKit

class PaymentCell: UITableViewCell {
    @IBOutlet var brand_lbl: UILabel!
    @IBOutlet var include_lbl: UILabel!
    @IBOutlet var card_lbl: UILabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet var Switch_OnOff: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

