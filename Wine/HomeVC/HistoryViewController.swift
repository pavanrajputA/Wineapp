//
//  HistoryViewController.swift
//  Wine
//
//  Created by Apple on 06/09/21.
//

import UIKit
import Alamofire


class HistoryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblView: UITableView!
    var arrList :NSMutableArray = NSMutableArray()
    var getarrList :NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = true
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "HistorylistTableViewCell", bundle: nil), forCellReuseIdentifier: "HistorylistTableViewCell")
       
        
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
            
            let islogin = UserDefaults.standard.string(forKey: "Islogin")
        
        if islogin == "YES"{
            self.HistoryList_API()
            }
        
    }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)

    }
    
/**************************************************************************/
//MARK:-  ApI Call socialLogin///
/**************************************************************************/
func HistoryList_API() {
    MBProgressHUD.showAdded(to: self.view, animated: true)
    
    let userDefaults = UserDefaults.standard
    let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
    let email = Userdetails["useremail"] as? String ?? ""
    
    
    let parameters: Parameters = ["useremail" : email]
    let urlString = producthistory
    let url = URL.init(string: urlString)
    AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
        switch response.result
        {
        case .success(let json):
            let jsonData = json as! Any
            self.HistoryListAPICallFinished(json as! NSDictionary)
        case .failure(let error):
            self.HistoryListAPICallError(error)
        }
    }
}
func HistoryListAPICallFinished(_ dictPlayersInfo: NSDictionary)
{
    let data = dictPlayersInfo["data"] as? NSDictionary
    let status = dictPlayersInfo["status"] as! NSNumber
    let message = dictPlayersInfo["message"] as! String
    if (status == 1) {
        let userdata = data!["listItem"] as! NSArray
        for i in userdata{
            getarrList.add(i as! NSDictionary)
        }
        
        self.arrList =  NSMutableArray(array: self.getarrList.reverseObjectEnumerator().allObjects).mutableCopy() as! NSMutableArray
        tblView.reloadData()
    }else{
        ShowCustomAlert.show(withMessage:message)
    }
    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
}
func HistoryListAPICallError(_ error: Error)
{
    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
}

}
extension HistoryViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrList.count
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistorylistTableViewCell", for: indexPath) as? HistorylistTableViewCell else { return UITableViewCell() }
        
      let dict = arrList.object(at: indexPath.row) as? NSDictionary
        let grandTotal = dict!["grandTotal"] as! NSDictionary
        
        cell.lblDate.text = "Ordered item in \(grandTotal.GotValue(key: "orderDate") as String)"
        cell.lblSuccess.text = "Payment \(grandTotal.GotValue(key: "PaymentStatus") as String)"
        
        if (grandTotal.GotValue(key: "PaymentStatus") as String) == "failed"{
            cell.lblSuccess.textColor = .red
        }else{
            cell.lblSuccess.textColor = .green
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = arrList.object(at: indexPath.row) as? NSDictionary
        let grandTotal = dict!["grandTotal"] as! NSDictionary
        //let productDetails_list = dict!["productDetails"] as! NSMutableArray
        let productDetails_list = dict!["productDetails"] as! NSArray
        let local_arr : NSMutableArray = NSMutableArray()
        for i in productDetails_list{
            local_arr.add(i as! NSDictionary)
        }
        let dicForAddress_history = grandTotal["address"] as! NSDictionary
        let Nextpage = self.storyboard?.instantiateViewController(withIdentifier: "HistoryDetailsViewController") as! HistoryDetailsViewController
        Nextpage.arrListReceipt = local_arr as! NSMutableArray
        Nextpage.dicForAddress = dicForAddress_history as! NSDictionary
        Nextpage.dicForrecipt = grandTotal as! NSDictionary
        self.navigationController?.pushViewController(Nextpage, animated: false)
    }
    
    
}
