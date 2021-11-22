//
//  HomeTableViewCell.swift
//  Wine
//
//  Created by Apple on 13/07/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var viewMainForCell: UIView!
    @IBOutlet weak var imageDis: UIImageView!
    @IBOutlet weak var hightImage: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
