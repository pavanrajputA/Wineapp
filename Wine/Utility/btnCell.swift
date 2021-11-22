//
//  btnCell.swift
//  Wine
//
//  Created by Apple on 21/07/21.
//

import UIKit

class btnCell: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 3.0
        layer.cornerRadius = 12
        layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 3.0
        layer.cornerRadius = 12
        layer.masksToBounds = false
    }

}
