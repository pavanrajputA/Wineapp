//
//  FaildPaymentViewController.swift
//  Wine
//
//  Created by Apple on 11/09/21.
//

import UIKit

class FaildPaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnProceedtohome(_ sender: Any) {
     
        self.navigationController?.popToRoot(animated: false)
    }
    

}
