//
//  SuggestionListTableViewCell.swift
//  Wine
//
//  Created by Apple on 20/07/21.
//

import UIKit

class SuggestionListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var viewMainForCell: UIView!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var btnAddCellar: UIButton!
    
    @IBOutlet weak var imageViewda: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
