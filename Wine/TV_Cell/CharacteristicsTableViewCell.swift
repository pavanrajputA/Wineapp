//
//  CharacteristicsTableViewCell.swift
//  Wine
//
//  Created by Apple on 09/08/21.
//

import UIKit

class CharacteristicsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblKay: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
