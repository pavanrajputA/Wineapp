//
//  ProfileViewController.swift
//  Wine
//
//  Created by Apple on 16/07/21.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        APPDELEGATE.isBack = true
    }

}
