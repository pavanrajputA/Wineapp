//
//  View_Shadow.swift
//  SwaplNFC
//
//  Created by Apple on 04/05/21.
//

import UIKit

class View_Shadow: UIView {

 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 30.0
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        

        
        layer.cornerRadius = 30.0
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.masksToBounds = true
    }
    
    
}
