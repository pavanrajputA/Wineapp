//
//  NewFileMycellarViewController.swift
//  Wine
//
//  Created by Pavan on 20/10/21.
//

import UIKit

class NewFileMycellarViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
     @IBOutlet var lblTitleheader: UILabel!
    var arrList :NSMutableArray = NSMutableArray()
    var fullarrList :NSMutableArray = NSMutableArray()

     @IBOutlet weak var btnBagCount: UIButton!
    @IBOutlet weak var lblNodatafound: UILabel!
     var isBack = true
     var selectedType = ""
     var dataCategories = NSDictionary()
    var userDefaults = UserDefaults.standard
     override func viewDidLoad() {
         super.viewDidLoad()
         lblTitleheader.text = selectedType
         tblView.delegate = self
         tblView.dataSource = self
         tblView.separatorStyle = .none
         tblView.isScrollEnabled = true
         tblView.backgroundColor = .clear
         tblView.register(UINib(nibName: "SuggestionListTableViewCell", bundle: nil), forCellReuseIdentifier: "SuggestionListTableViewCell")
        
         tblView.layoutIfNeeded()
         tblView.reloadData()
         APPDELEGATE.isBack = false
         
         if arrList.count == 0{
             lblNodatafound.isHidden = false
         }else{
             lblNodatafound.isHidden = true
         }
         
     }
     override func viewDidAppear(_ animated: Bool) {
         if APPDELEGATE.isBack == true {
             self.navigationController?.popToRoot(animated: false)
             APPDELEGATE.isBack = false
         }else{
             APPDELEGATE.isBack = false
         }
         
         let localArrCount = localarrCount()
         btnBagCount.setTitle("\(localArrCount)", for: .normal)
         btnBagCount.setTitleColor(.black, for: .normal)
     }
     override func viewDidLayoutSubviews(){
     tblView.reloadData()
 }
     
     @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.pop(animated: true)
         isBack = true
     }
    
     @IBAction func btnBag(_ sender: Any) {
        
         let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
        // editProfile.dicDetails = dict! as NSDictionary
         
         self.navigationController?.pushViewController(editProfile, animated: false)
     }
     

 }

 extension NewFileMycellarViewController {
     
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return arrList.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionListTableViewCell", for: indexPath) as? SuggestionListTableViewCell else { return UITableViewCell() }
         cell.btnDetails.tag = indexPath.row
         cell.btnDetails.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
         cell.btnAddCellar.isHidden = true
         let dict = arrList.object(at: indexPath.row) as? NSDictionary
         cell.lblFirst.text = dict!["name"] as! String
         cell.lblSecond.text = dict!["description"] as! String
         cell.imageViewda.layer.cornerRadius = 13.0
         cell.imageViewda.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
         cell.imageViewda.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
         let imageURL =  imagePath + "\(dict!.GotValue(key: "image") as String)"
         
         var imageUrl: URL? {
             if let url = URL(withCheck: imageURL) {
                 return url
             }
             if let url = URL(withCheck: imageURL) {
                 return url
             }
             return nil
         }
         
         cell.imageViewda.sd_setShowActivityIndicatorView(true)
             cell.imageViewda.sd_setIndicatorStyle(.gray)
         cell.imageViewda?.sd_setImage(with: imageUrl) { (image, error, cache, urls) in
                 if (error != nil) {
                     cell.imageViewda.image = #imageLiteral(resourceName: "4")
                     cell.imageViewda.sd_setShowActivityIndicatorView(false)
                 } else {
                     cell.imageViewda.image = image
                     cell.imageViewda.sd_setShowActivityIndicatorView(false)
                 }
             }
         return cell
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let dict = arrList.object(at: indexPath.row) as? NSDictionary
         let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "VarietalDetailsViewController") as! VarietalDetailsViewController
         editProfile.selectedType = dict!["name"] as! String
         editProfile.dataDetails = dict as! NSDictionary
         self.navigationController?.pushViewController(editProfile, animated: false)

     }
     @objc func connected(sender: UIButton){
         let buttonTag = sender.tag
         let dict = arrList.object(at: buttonTag) as? NSDictionary
         let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "VarietalDetailsViewController") as! VarietalDetailsViewController
         editProfile.selectedType = dict!["name"] as! String
         editProfile.dataDetails = dict as! NSDictionary
         self.navigationController?.pushViewController(editProfile, animated: false)
     }
     
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
      
         let Reject = UITableViewRowAction(style: .normal, title: "Delete") { action, index in

             self.rejectFunc(indexPath: indexPath)
         }
         Reject.backgroundColor = .red

         return [Reject]
     }
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
     }

     func rejectFunc(indexPath: IndexPath) {
         print(indexPath.row)
         
        
         
         if let dict = arrList.object(at: indexPath.row) as? NSDictionary {
             
             print(dict)
             let cardid = (dict.GotValue(key: "id") as String)
             let actionSheetController: UIAlertController = UIAlertController(title: "Remove Item", message: "Do you want to remove item from your my cellar list?", preferredStyle: .alert)
             let cancelAction: UIAlertAction = UIAlertAction(title: "no", style: .cancel) { action -> Void in
                 //Do your task
             }
             actionSheetController.addAction(cancelAction)
             let nextAction: UIAlertAction = UIAlertAction(title: "yes", style: .default) { action -> Void in
                 let reachability = Reachability()!
                 if !reachability.isReachable
                 {
                     ShowCustomAlert.showCenter(withMessage: "internet issue")
                 }else{
                     let dict1 = self.fullarrList.object(at: indexPath.row) as? NSDictionary
                     let id = (dict.GotValue(key: "id") as String)
                     for i in self.fullarrList{
                         var itmedata = i as! NSDictionary
                         var current = (itmedata.GotValue(key: "id") as String)
                         if id == current{
                             self.fullarrList.remove(i)
                         }
                     }
                     var loclArrey : NSMutableArray = NSMutableArray()
                     for i in self.fullarrList{
                         loclArrey.add(i as! NSDictionary)
                     }
                     self.userDefaults.set(loclArrey, forKey: "cellarDatalist")
                     self.arrList = NSMutableArray()
                     let localcall = UserDefaults.standard.object(forKey: "cellarDatalist") as? NSArray ?? []
                             for i in localcall{
                                 var itmedata = i as! NSDictionary
                                 if itmedata["type"] as! String == "Experiences" && self.selectedType == "Experiences"{
                                     self.arrList.add(itmedata)
                                 }else if itmedata["type"] as! String == "Extend My Palate" && self.selectedType == "Extend My Palate"{
                                     self.arrList.add(itmedata)
                                 }else if itmedata["type"] as! String == "Food pairings" && self.selectedType == "Food pairings"{
                                     self.arrList.add(itmedata)
                                 }
                             }
                     self.tblView.reloadData()
                 }
             }
             
             actionSheetController.addAction(nextAction)
             self.present(actionSheetController, animated: true, completion: nil)
         }
         
         
     }
     
 }
