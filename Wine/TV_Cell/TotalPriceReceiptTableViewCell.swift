//
//  TotalPriceReceiptTableViewCell.swift
//  Wine
//
//  Created by Apple on 01/09/21.
//

import UIKit

class TotalPriceReceiptTableViewCell: UITableViewCell {

    @IBOutlet weak var lblShippingcharges: UILabel!
    @IBOutlet weak var lblStatetax: UILabel!
    @IBOutlet weak var lblStatePrice: UILabel!
    @IBOutlet weak var lblTotalamount: UILabel!
    @IBOutlet weak var lblOrdernumber: UILabel!
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblAddress1: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblZip: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    @IBOutlet weak var viewFortotal: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
