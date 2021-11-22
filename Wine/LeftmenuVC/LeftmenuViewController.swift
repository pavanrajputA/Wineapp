//
//  LeftmenuViewController.swift
//  Travialist
//
//  Created by mindcrewtechnologies on 25/10/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
import SafariServices
class LeftmenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,SFSafariViewControllerDelegate {
    @IBOutlet weak var tblLeftMenu: UITableView!
    var userDefaults = UserDefaults.standard
    var arrayofMenu:NSArray = [] ;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tblLeftMenu.allowsSelection = true
        
        arrayofMenu = [
            ["menuPicture": "house", "menuName": NSLocalizedString("Home", comment: "")],
            ["menuPicture": "Avtar", "menuName": NSLocalizedString("Login/Signup", comment: "")],
            ["menuPicture": "logout", "menuName": NSLocalizedString("Logout", comment: "")],
        ]
        
        tblLeftMenu.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tblLeftMenu.allowsSelection = true
        
        arrayofMenu = [
            ["menuPicture": "house", "menuName": NSLocalizedString("Home", comment: "")],
            ["menuPicture": "Avtar", "menuName": NSLocalizedString("Login/Signup", comment: "")],
            ["menuPicture": "logout", "menuName": NSLocalizedString("Logout", comment: "")],
        ]
        tblLeftMenu.reloadData()
        
     
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayofMenu.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuTableViewCell
        let dict:NSDictionary = arrayofMenu[indexPath.row] as! NSDictionary
        cell.imgmenu.image = UIImage(named: dict.object(forKey: "menuPicture") as! String)
        cell.lblMenuName.text = dict.object(forKey: "menuName") as! NSString as String
        return cell;
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath as IndexPath)
        // cell?.contentView.backgroundColor = UIColor.orangeColor()
    }
    
    // MARK: - UITableView delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch(indexPath.row)
        {
        case 0:
            
            let elDrawer = (self.navigationController!.parent! as! KYDrawerController)
            elDrawer.setDrawerState(.closed, animated: true)
            break
        case 1:
            
            let islogin = UserDefaults.standard.string(forKey: "Islogin")
            if islogin == "YES"{
                let elDrawer = (self.navigationController!.parent! as! KYDrawerController)
                elDrawer.setDrawerState(.closed, animated: true)
                ShowCustomAlert.showCenter(withMessage: "Already logged in")

            }else{
                let elDrawer = (self.navigationController!.parent! as! KYDrawerController)
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                let navController = UINavigationController(rootViewController: viewController)
                navController.isNavigationBarHidden = true
                elDrawer.mainViewController = navController
                elDrawer.setDrawerState(.closed, animated: true)
            }
            
//            let elDrawer = (self.navigationController!.parent! as! KYDrawerController)
//            elDrawer.setDrawerState(.closed, animated: true)

            
            break
        case 2:
            
            let islogin = UserDefaults.standard.string(forKey: "Islogin")
            if islogin == "YES"{
        let actionSheetController: UIAlertController = UIAlertController(title: "Do you want to logout?", message: "", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel) { action -> Void in
            //Do your task
        }
        actionSheetController.addAction(cancelAction)
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
            UserDefaults.standard.removeObject(forKey:"LOGIN")
            UserDefaults.standard.removeObject(forKey:"userdata")
            UserDefaults.standard.removeObject(forKey:"shippingDetails")
            ShowCustomAlert.showCenter(withMessage: "Logout Successfully")
            
            if #available(iOS 13.0, *) {
                let elDrawer = (self.navigationController!.parent! as! KYDrawerController)
                elDrawer.setDrawerState(.closed, animated: true)
                UserDefaults.standard.set("NO", forKey: "Islogin")
            }else {
                let elDrawer = (self.navigationController!.parent! as! KYDrawerController)
                elDrawer.setDrawerState(.closed, animated: true)
                UserDefaults.standard.set("NO", forKey: "Islogin")
            }
            
        }
        
        actionSheetController.addAction(nextAction)
                self.present(actionSheetController, animated: true, completion: nil)
                
            }else{
                ShowCustomAlert.showCenter(withMessage: "Already Logout, Please login first")
            }
            break
            
        case 3:
         //   self.showSafariVC(for: "https://www.born2evolve.com/pages/born2evolve-app")
            break
        case 4:
//            let elDrawer = (self.navigationController!.parent! as! KYDrawerController)
//            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowtoconnectVC")
//            let navController = UINavigationController(rootViewController: viewController)
//            navController.isNavigationBarHidden = true
//            elDrawer.mainViewController = navController
//            elDrawer.setDrawerState(.closed, animated: true)
            break
            
        default:
            break
        }
        
    }
    //MARK: - UITableView delegates
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
            //cell.backgroundColor = UIColor.yellow
        }
        
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
            // cell.backgroundColor = UIColor.yellow
        }
        
        
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
            //cell.backgroundColor = UIColor.yellow
        }
        //declaring the cell variable again
        
    }
    
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true) {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
