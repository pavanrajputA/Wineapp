//
//  WizardViewController.swift
//  Wine
//
//  Created by Apple on 13/07/21.
//

import UIKit

class WizardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var arr : NSMutableArray = NSMutableArray()
    var dic1 = NSMutableDictionary()
    var dic2 = NSMutableDictionary()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView()
        
        dic1 = ["cellType": "First" ]
        dic2 = ["cellType": "second"]
        arr.add(dic1)
        arr.add(dic2)
        
        tableView.register(UINib(nibName: "WizardTableViewCell", bundle: nil), forCellReuseIdentifier: "WizardTableViewCell")
        tableView.register(UINib(nibName: "WizardFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "WizardFirstTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APPDELEGATE.isBack = true
    

    }
    
    //MARK:-  tableview
    func numberOfSections(in tableView: UITableView) -> Int {
    return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict = arr.object(at: indexPath.row) as? NSDictionary
        switch indexPath.section {
            case 0:
                print("contract detail")
                let cell = tableView.dequeueReusableCell(withIdentifier: "WizardFirstTableViewCell", for: indexPath)
                let vieww = Bundle.main.loadNibNamed("WizardFirstTableViewCell", owner: self, options: nil)?.first as? WizardFirstTableViewCell

//                cell.contentView.addSubview(vieww!)
//                vieww?.frame = cell.contentView.frame
//                vieww?.center = cell.contentView.center

                return cell
            case 1:
                print("passenger")
                let cell = tableView.dequeueReusableCell(withIdentifier: "WizardTableViewCell", for: indexPath)
                let vieww = Bundle.main.loadNibNamed("WizardTableViewCell", owner: self, options: nil)?.first as? WizardTableViewCell


                return cell
    

            default:
                print("nothing")
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

                return cell
            }
    }

 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0{
            return 500.0
        }else{
            return 400.0
        }
        
       
    }
    
}
