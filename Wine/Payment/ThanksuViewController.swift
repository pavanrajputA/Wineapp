//
//  ThanksuViewController.swift
//  Wine
//
//  Created by Apple on 02/08/21.
//

import UIKit

class ThanksuViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
   
    
    }
    

    @IBAction func btnProceedtohome(_ sender: Any) {
     
        self.navigationController?.popToRoot(animated: false)
    }
    
    
}

