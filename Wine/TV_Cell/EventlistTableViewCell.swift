//
//  EventlistTableViewCell.swift
//  Wine
//
//  Created by Apple on 20/07/21.
//

import UIKit

class EventlistTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewMainForCell: UIView!
    @IBOutlet weak var imageDis: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
