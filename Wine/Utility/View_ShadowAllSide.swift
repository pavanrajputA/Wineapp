//
//  View_ShadowAllSide.swift
//  SwaplNFC
//
//  Created by apple on 2/27/21.
//

import UIKit

class View_ShadowAllSide: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)

        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        

        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
}
