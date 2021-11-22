//
//  ForWineCollectionViewCell.swift
//  Wine
//
//  Created by Apple on 26/07/21.
//

import UIKit

class ForWineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ratingView : FloatRatingView!
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblReview : UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
