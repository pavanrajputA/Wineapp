//
//  App_TF.swift
//  SwaplNFC
//
//  Created by apple on 2/26/21.
//

import UIKit

class App_TF: UITextField {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 50.0))
        self.leftView = view;
        self.leftViewMode = .always
                
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.1
        layer.cornerRadius = 20
        layer.masksToBounds = false
        layer.shadowRadius = 2.0
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowOffset =  CGSize(width: 0, height: 1)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 50.0))
        self.leftView = view;
        self.leftViewMode = .always

        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.1
        layer.cornerRadius = 20
        layer.masksToBounds = false
        layer.shadowRadius = 2.0
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowOffset =  CGSize(width: 0, height: 1)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2.0
        
        
    }
}
