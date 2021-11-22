//
//  AddressTableViewCell.swift
//  Wine
//
//  Created by Apple on 03/09/21.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblAddress1: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblZip: UILabel!
    
    @IBOutlet weak var btnIsSelected: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imageselecte: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
