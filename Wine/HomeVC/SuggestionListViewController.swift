//
//  SuggestionListViewController.swift
//  Wine
//
//  Created by Apple on 20/07/21.
//

import UIKit
import Alamofire

class SuggestionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   @IBOutlet weak var tblView: UITableView!
    @IBOutlet var lblTitleheader: UILabel!
   var arrList :NSMutableArray = NSMutableArray()

    @IBOutlet weak var btnBagCount: UIButton!

    var isBack = true
    var selectedType = ""
    var dataCategories = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleheader.text = selectedType
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = true
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "SuggestionListTableViewCell", bundle: nil), forCellReuseIdentifier: "SuggestionListTableViewCell")
        
        
  
        let id = dataCategories["id"] as! NSNumber
        lblTitleheader.text = dataCategories["name"] as! String
        
       print( dataCategories)
        
        
        let reachability = Reachability()!
        if !reachability.isReachable
        {
            let actionSheetController: UIAlertController = UIAlertController(title: "Internet is not responding. Please check the connection.", message: "", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "ok", style: .cancel) { action -> Void in
                //Do your task
            }
            actionSheetController.addAction(cancelAction)
            self.present(actionSheetController, animated: true, completion: nil)
            
        } else {
           self.listSubsubSubCategories_API(type: "\(id)")
            }
        
    
        
        tblView.layoutIfNeeded()
        
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
    @IBAction func btnDetails(_ sender: Any) {
  
    }
    @IBAction func btnBag(_ sender: Any) {
       
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
       // editProfile.dicDetails = dict! as NSDictionary
        
        self.navigationController?.pushViewController(editProfile, animated: false)
    }
    
    /**************************************************************************/
    //MARK:-  ApI Call ///
    /**************************************************************************/
    func listSubsubSubCategories_API(type:String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        
        let sub = dataCategories.GotValue(key: "subId")
        let parameters: Parameters = ["id" : type, "subId": sub]
        let urlString = listSubsubsubCategories
        
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                        switch response.result
                       {
                       case .success(let json):
                           let jsonData = json as! Any
               self.SubsubsubCategoriesAPICallFinished(json as! NSDictionary)
                       case .failure(let error):
                           self.SubsubsubCategoriesAPICallError(error)
                       }
        }
    }
        func SubsubsubCategoriesAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["Message"] as! String
        if (status == 1) {
            let userdata = data!["list"] as! NSArray
            for i in userdata{
                arrList.add(i as! NSDictionary)
            }
            tblView.reloadData()
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
       
    }
    func SubsubsubCategoriesAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
}

extension SuggestionListViewController {
    
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
        cell.btnAddCellar.tag = indexPath.row
        cell.btnAddCellar.addTarget(self, action: #selector(Addcellar(sender:)), for: .touchUpInside)
        
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
    
    @objc func Addcellar(sender: UIButton){
        let buttonTag = sender.tag
        let dict = arrList.object(at: buttonTag) as? NSDictionary
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "cellarDatalist") as? NSDictionary ?? [:]
        print(Userdetails)
 
        var dicNewdata: NSDictionary = ["id": dict!["id"] as! NSNumber,"image": "\(dict!.GotValue(key: "image") as String)", "name": dict!["name"] as! String ,"description":  dict!["description"] as! String,"type":  APPDELEGATE.strSelectedType]
        var arrlocl : NSMutableArray = NSMutableArray()
        let localcall = UserDefaults.standard.object(forKey: "cellarDatalist") as? NSArray ?? []
        for i in localcall {
            var winedata = i as! NSDictionary
            var id = winedata["id"] as! NSNumber
            if (dicNewdata["id"] as! NSNumber == id) {
                arrlocl.remove(i)
            }else{
                arrlocl.add(i as! NSDictionary)
            }
        }
        arrlocl.add(dicNewdata)
        userDefaults.set(arrlocl, forKey: "cellarDatalist")
        
        ShowCustomAlert.showCenter(withMessage: "Added item in 'My Cellar'")
    }
}
class DynamicHeightTableView: UITableView {
  override open var intrinsicContentSize: CGSize {
    return contentSize
  }
}

