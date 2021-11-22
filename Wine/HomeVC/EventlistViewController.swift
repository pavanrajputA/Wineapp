//
//  EventlistViewController.swift
//  Wine
//
//  Created by Apple on 20/07/21.
//

import UIKit
import Alamofire
class EventlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var lblTitleheader: UILabel!
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var tblView: UITableView!
    var arrList :NSMutableArray = NSMutableArray()
    var isBack = true
    var selectedType = ""
    var fullDicData = NSDictionary()
    
    @IBOutlet weak var btnBagCount: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let id = fullDicData["id"] as! NSNumber
        lblTitleheader.text = fullDicData["name"] as! String
        
        
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
            self.listSubCategories_API(type: "\(id)")
             }
        
       
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = true
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "EventlistTableViewCell", bundle: nil), forCellReuseIdentifier: "EventlistTableViewCell")
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    @IBAction func btnBag(_ sender: Any) {
        
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
        self.navigationController?.pushViewController(editProfile, animated: false)
    }
    
    /**************************************************************************/
    //MARK:-  ApI Call socialLogin///
    /**************************************************************************/
    func listSubCategories_API(type:String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let parameters: Parameters = ["id" : type]
        let urlString = listSubCategories
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.SubCategoriesAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.SubCategoriesAPICallError(error)
            }
        }
    }
    func SubCategoriesAPICallFinished(_ dictPlayersInfo: NSDictionary)
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
    func SubCategoriesAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
}

extension EventlistViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventlistTableViewCell", for: indexPath) as? EventlistTableViewCell else { return UITableViewCell() }
        
        let dict = arrList.object(at: indexPath.row) as? NSDictionary
        cell.btnNext.tag = indexPath.row
        cell.btnNext.addTarget(self, action: #selector(btnNext(sender:)), for: .touchUpInside)
        cell.imageDis.layer.cornerRadius = 10.0
        cell.imageDis.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        cell.imageDis.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        
        let imageURL =  imagePath + "\(dict!["image"] as! String)"
        cell.imageDis.sd_setShowActivityIndicatorView(true)
        cell.imageDis.sd_setIndicatorStyle(.gray)
        
        var imageUrl: URL? {
            if let url = URL(withCheck: imageURL) {
                return url
            }
            if let url = URL(withCheck: imageURL) {
                return url
            }
            return nil
        }
        
        cell.imageDis?.sd_setImage(with: imageUrl) { (image, error, cache, urls) in
            if (error != nil) {
                cell.imageDis.image = #imageLiteral(resourceName: "4")
                cell.imageDis.sd_setShowActivityIndicatorView(false)
            } else {
                cell.imageDis.image = image
                cell.imageDis.sd_setShowActivityIndicatorView(false)
            }
        }
        cell.lblInfo.text = "\(dict!.GotValue(key: "description") as! String)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = arrList.object(at: indexPath.row) as? NSDictionary
        
        if dict?.GotValue(key: "subId") == "no"{
    
            
            let dict = arrList.object(at: indexPath.row) as? NSDictionary
            print(dict)
            
            let NextPage = self.storyboard?.instantiateViewController(withIdentifier: "SuggestionListViewController") as! SuggestionListViewController
            NextPage.selectedType =  dict!["name"] as! String
            NextPage.dataCategories = dict as! NSDictionary
            
            self.navigationController?.pushViewController(NextPage, animated: false)
            
        }else{
            
            
            let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "PocornSubcatViewController") as! PocornSubcatViewController
            editProfile.dataForSubcategories = dict as! NSDictionary
            self.navigationController?.pushViewController(editProfile, animated: false)
            
        }
        

    }
    @objc func btnNext(sender: UIButton){
        let buttonTag = sender.tag
        let dict = arrList.object(at: buttonTag) as? NSDictionary
        
        if dict?.GotValue(key: "subId") == "no"{
    
            
            let dict = arrList.object(at: buttonTag) as? NSDictionary
            print(dict)
            
            let NextPage = self.storyboard?.instantiateViewController(withIdentifier: "SuggestionListViewController") as! SuggestionListViewController
            NextPage.selectedType =  dict!["name"] as! String
            NextPage.dataCategories = dict as! NSDictionary
            
            self.navigationController?.pushViewController(NextPage, animated: false)
            
        }else{
            
            
            let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "PocornSubcatViewController") as! PocornSubcatViewController
            editProfile.dataForSubcategories = dict as! NSDictionary
            self.navigationController?.pushViewController(editProfile, animated: false)
            
        }
        
    }
    
}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
extension URL {

  init?(withCheck string: String?) {
    let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
    guard
        let urlString = string,
        let url = URL(string: urlString),
        NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx]).evaluate(with: urlString),
        UIApplication.shared.canOpenURL(url)
        else {
            return nil
    }

    self = url
  }
}
