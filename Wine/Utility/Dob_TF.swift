//
//  App_TF.swift
//  SwaplNFC
//
//  Created by apple on 2/26/21.
//

import UIKit

class Dob_TF: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 50.0))
        self.leftView = view;
        self.leftViewMode = .always
        
        self.backgroundColor = .white
//        self.font = UIFont(name:Font_CoreSansD45Medium, size: 30)!
        self.textColor = .black
       
        layer.cornerRadius = 10.0
        layer.borderWidth = 1.0
        layer.borderColor = hexStringToUIColor(hex: "C4C4C4").cgColor
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 50.0))
        self.leftView = view;
        self.leftViewMode = .always
        
        self.backgroundColor = .white
//        self.font = UIFont(name:Font_CoreSansD45Medium, size: 30)!
        self.textColor = .black
        
        layer.cornerRadius = 10.0
        layer.borderWidth = 1.0
        layer.borderColor = hexStringToUIColor(hex: "C4C4C4").cgColor
        layer.masksToBounds = true
    }
    override func caretRect(for position: UITextPosition) -> CGRect {
           return CGRect.zero
       }

    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(cut(_:)) ||
               action == #selector(copy(_:)) ||
               action == #selector(UIResponderStandardEditActions.paste(_:)) ||
               action == #selector(UIResponderStandardEditActions.select(_:)) ||
               action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||
               action == #selector(UIResponderStandardEditActions.delete(_:)) 
               
            {
                 return false
            };
            return true
        }

}
