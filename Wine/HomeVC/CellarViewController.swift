//
//  CellarViewController.swift
//  Wine
//
//  Created by Apple on 16/07/21.
//

import UIKit

class CellarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblView: UITableView!
    var arrList :NSMutableArray = NSMutableArray()
    
    var dic1 = NSMutableDictionary()
    var dic2 = NSMutableDictionary()
    var dic3 = NSMutableDictionary()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblView.delegate = self
        tblView.dataSource = self
        tblView.bouncesZoom = false
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = true
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        dic1 = ["Imagename": "Experiences" ,"dis":"Touche's Backed Breads, Bourough"]
        dic2 = ["Imagename": "Extend My Palate" ,"dis":"Hedonism Wines"]
        dic3 = ["Imagename": "Food pairings" ,"dis":"Coffee with wine"]
        
        arrList.add(dic1)
        arrList.add(dic2)
        arrList.add(dic3)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        APPDELEGATE.isBack = true
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        if let elDrawer = self.navigationController?.parent as? KYDrawerController {
            elDrawer.setDrawerState(.opened, animated: true)
        }else if let elDrawer = self.navigationController?.parent?.parent as? KYDrawerController {
            elDrawer.setDrawerState(.opened, animated: true)
        } else {
            let elDrawer = (self.navigationController!.parent?.parent?.parent! as!  KYDrawerController)
            elDrawer.setDrawerState(.opened, animated: true)
    }
}
}
extension CellarViewController {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrList.count
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 230.0
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
            
            let dict = arrList.object(at: indexPath.row) as? NSDictionary
            cell.imageDis?.image =  UIImage(named: "\(dict!.GotValue(key: "Imagename") as String)")
            cell.imageDis.layer.cornerRadius = 25.0
            cell.imageDis.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.imageDis.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.imageDis.layer.shadowOpacity = 1
            cell.imageDis.layer.shadowRadius = 2.0
            
            //cell.imageDis.sizeToFit()
            
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let arrListExperience :NSMutableArray = NSMutableArray()
            let arrListExtend :NSMutableArray = NSMutableArray()
            let arrListFood :NSMutableArray = NSMutableArray()
            let fullarrList :NSMutableArray = NSMutableArray()
            
            let localcall = UserDefaults.standard.object(forKey: "cellarDatalist") as? NSArray ?? []
                    for i in localcall{
                        let itmedata = i as! NSDictionary
                        if itmedata["type"] as! String == "Experiences"{
                            arrListExperience.add(itmedata)
                        }else if itmedata["type"] as! String == "Extend My Palate"{
                            arrListExtend.add(itmedata)
                        }else if itmedata["type"] as! String == "Food pairings"{
                            arrListFood.add(itmedata)
                        }
                        
                        fullarrList.add(itmedata)
                    }
            
            let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "NewFileMycellarViewController") as! NewFileMycellarViewController
            let dict = arrList.object(at: indexPath.row) as? NSDictionary
            
            
            if  dict!["Imagename"] as! String == "Experiences"{
                editProfile.arrList = arrListExperience
            }else if  dict!["Imagename"] as! String == "Extend My Palate"{
                editProfile.arrList = arrListExtend
            }else if  dict!["Imagename"] as! String == "Food pairings"{
                editProfile.arrList = arrListFood
            }
            editProfile.selectedType = dict!["Imagename"] as! String
            editProfile.fullarrList = fullarrList
                self.navigationController?.pushViewController(editProfile, animated: false)
        }
    }
