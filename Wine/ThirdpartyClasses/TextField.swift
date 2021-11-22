//
//  TextField.swift
//  datepicker without cursor
//
//  Created by Apoorv Mote on 11/01/16.
//  Copyright © 2016 Apoorv Mote. All rights reserved.
//

// 6
import UIKit

class TextField: UITextField {
    // 8
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
            
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}
