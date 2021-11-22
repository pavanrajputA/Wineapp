//
//  View_ShadowClass.swift
//  SwaplNFC
//
//  Created by Apple on 27/02/21.
//

import UIKit

class View_ShadowClass: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
//                backgroundColor = hexStringToUIColor(hex: "000000")
        layer.cornerRadius = 10.0
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        backgroundColor = hexStringToUIColor(hex: "000000")
        layer.cornerRadius = 10.0
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
    }
}
