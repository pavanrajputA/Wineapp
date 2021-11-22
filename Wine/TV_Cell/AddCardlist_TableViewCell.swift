//
//  AddCardlist_TableViewCell.swift
//  Wine
//
//  Created by Apple on 28/07/21.
//

import UIKit

class AddCardlist_TableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnPluse: UIButton!
    @IBOutlet weak var btnMinice: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var imageWine: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
