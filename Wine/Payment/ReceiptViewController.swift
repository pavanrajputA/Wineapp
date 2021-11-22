//
//  ReceiptViewController.swift
//  Wine
//
//  Created by Apple on 02/09/21.
//

import UIKit
import Alamofire
class ReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var arrListSend : NSMutableArray = NSMutableArray()
    
    var cardID_str = ""
    var dicForrecipt : NSDictionary = NSDictionary()
    var dicForAddress : NSDictionary = NSDictionary()
    
    @IBOutlet weak var tblView: UITableView!
    var arrListReceipt :NSMutableArray = NSMutableArray()
    var idStr = ""
    var isBack = true
    
    var shippind_Dic = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        let email = Userdetails["useremail"] as? String ?? ""
        let parameters: Parameters = ["useremail" : email]
        // Do any additional setup after loading the view.
        
        
        let localcall = UserDefaults.standard.object(forKey: "userproductdata") as? NSArray ?? []
        
        for i in localcall{
            let itmedata = i as! NSDictionary
        
            let id = itmedata["id"] as! NSNumber
            let count = itmedata["count"] as! NSNumber
            
            let dic = ["id" : id, "count" : count]
            arrListSend.add(dic)
        }
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
            self.getIFoItim_API()
            }
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = true
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "ReceiptTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiptTableViewCell")
        tblView.register(UINib(nibName: "TotalPriceReceiptTableViewCell", bundle: nil), forCellReuseIdentifier: "TotalPriceReceiptTableViewCell")
        
       
        // Do any additional setup after loading the view.
    }
    //MARK:-  ApI Call get card list///
    /**************************************************************************/
    func getIFoItim_API() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        var email = Userdetails["useremail"] as? String ?? ""
 
        print(shippind_Dic)
        
    print((shippind_Dic["state_rate"] as! String))
        
       let parameters: Parameters = ["useremail" : email, "listitme" : arrListSend as NSArray, "stateRate" : "\(shippind_Dic["state_rate"] as! String)", "addressId" : "\(shippind_Dic["addressId"] as! NSNumber)"]
        print(parameters)
        
        let urlString = productsCalculetion
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.getInfoitemAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.getInfoitemAPICallError(error)
            }
        }
    }
    
    func getInfoitemAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
       
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let data = dictPlayersInfo["data"] as! NSDictionary
            let userdata = data as! NSDictionary
            print(userdata)
            dicForrecipt = userdata["grandTotal"] as! NSDictionary
            
            dicForAddress = dicForrecipt["address"] as! NSDictionary
            
            let listreceipt = userdata["listItem"] as! NSArray
            for i in listreceipt{
                arrListReceipt.add(i as! NSDictionary)
            }
            tblView.reloadData()
        }else{
            let alert = UIAlertController(title: "", message: "Something went wrong please try agin", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive , handler:{ (UIAlertAction)in
                //print("User click Delete button")
                self.getIFoItim_API()
            
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in
                //print("User click Delete button")
            }))
            
            self.present(alert, animated: true, completion: {
                // print("completion block")
            })
            
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
 
    }
    func getInfoitemAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
      
        let alert = UIAlertController(title: "", message: "Something went wrong please try agin", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive , handler:{ (UIAlertAction)in
            //print("User click Delete button")
            self.getIFoItim_API()
        
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in
            //print("User click Delete button")
        }))
        
        self.present(alert, animated: true, completion: {
            // print("completion block")
        })
        
    }
    @IBAction func btnPayment(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Do you want to pay now?", message: "", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do your task
        }
        
        let okAction: UIAlertAction = UIAlertAction(title: "Confirm", style: .default) { action -> Void in
            if self.dicForrecipt.GotValue(key: "Total") as String == ""{
                
            }else{
                
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
                    self.payment_API()
                    }
            }
        }
        
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(okAction)
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    
    //MARK:-  ApI Call get card list///
    /**************************************************************************/
    func payment_API() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        let email = Userdetails["useremail"] as? String ?? ""
        
    let totalAmount = dicForrecipt.GotValue(key: "Total") as String
    
        
        let parameters: Parameters = ["useremail" : email, "cardId" : cardID_str, "amount" : Float(totalAmount)]
        let urlString = paymentByuser
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.paymentAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.paymentAPICallError(error)
            }
        }
    }
    
    func paymentAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let status = dictPlayersInfo["status"] as! NSNumber
        print(dictPlayersInfo)
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            SendPaymentStatus_API(IsSuccess: 1)
        }else{
            ShowCustomAlert.showCenter(withMessage: message)
            SendPaymentStatus_API(IsSuccess: 0)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
 
    }
    func paymentAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        SendPaymentStatus_API(IsSuccess: 0)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
    
    //MARK:-  ApI Call patmentnt suceess api///
    /**************************************************************************/
    func SendPaymentStatus_API(IsSuccess : Int) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        let email = Userdetails["useremail"] as? String ?? ""
          let parameters: Parameters = ["status" : IsSuccess, "paymentId" : (dicForrecipt.GotValue(key: "orderId") as String),"useremail" : email,"amount" : dicForrecipt.GotValue(key: "Total"),"bottleCount" : dicForrecipt.GotValue(key: "bottleCount")]
     print(parameters)
        
        let urlString = paymentStatusSend
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.SendPaymentStatusAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.SendPaymentStatusAPICallError(error)
                
            }
        }
    }
    
    func SendPaymentStatusAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let StatusFortransection = dictPlayersInfo["paymentStatus"] as! Bool
            if StatusFortransection == false{
                let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "FaildPaymentViewController") as! FaildPaymentViewController
                    self.navigationController?.pushViewController(editProfile, animated: false)
            }else{
                let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ThanksuViewController") as! ThanksuViewController
                var arrlocl : NSMutableArray = NSMutableArray()
                let userDefaults = UserDefaults.standard
                userDefaults.set(arrlocl, forKey: "userproductdata")
                    self.navigationController?.pushViewController(editProfile, animated: false)
            }

        }else{
            ShowCustomAlert.showCenter(withMessage: "\(message)")
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
 
    }
    func SendPaymentStatusAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
    
    
    
}
extension ReceiptViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  section == 1 {
            return 1
        }else{
            return arrListReceipt.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
                // Updates
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TotalPriceReceiptTableViewCell", for: indexPath) as? TotalPriceReceiptTableViewCell else { return UITableViewCell() }
            cell.viewFortotal.layer.borderWidth = 1
            cell.viewFortotal.layer.borderColor = #colorLiteral(red: 0, green: 0.3176470588, blue: 0.8588235294, alpha: 1)

            cell.lblShippingcharges.text = "$" + "\(dicForrecipt.GotValue(key: "shippingCharge") as String)"
            cell.lblStatetax.text = "(\(dicForrecipt.GotValue(key: "stateTaxParsent") as String)" + "%)"
            cell.lblStatePrice.text = "$" + "\(dicForrecipt.GotValue(key: "stateRate") as String)"
            cell.lblTotalamount.text = "$" + "\(dicForrecipt.GotValue(key: "Total") as String)"
            cell.lblOrdernumber.text = "\(dicForrecipt.GotValue(key: "orderId") as String)"

            
            
            cell.lblFullName.text = "Name : " + "\(dicForAddress.GotValue(key: "fullname") as String)"
            cell.lblAddress1.text = "Address : " + "\(dicForAddress.GotValue(key: "address1") as String)"
            cell.lblCity.text = "City : " + "\(dicForAddress.GotValue(key: "city") as String)"
            cell.lblState.text = "State : " + "\(dicForAddress.GotValue(key: "state") as String)"
            cell.lblZip.text = "ZIP : " + "\(dicForAddress.GotValue(key: "zip") as String)"
            
            cell.lblDate.text = "Date : " + "\(dicForrecipt.GotValue(key: "date") as String)"

            
                return cell
            } else {
                // UpdatesTask
                guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "ReceiptTableViewCell", for: indexPath) as? ReceiptTableViewCell else { return UITableViewCell() }
                let dict = arrListReceipt.object(at: indexPath.row) as! NSDictionary
                
                let count = dict.GotValue(key: "count") as! String
                let price = dict.GotValue(key: "price") as! String
                let amount = Float(count)! * Float(price)!
                
                cell2.lblName.text = dict.GotValue(key: "name") as! String
                cell2.lblCount.text = dict.GotValue(key: "count") as! String
                cell2.lblPrice.text = "x $\(dict.GotValue(key: "price") as! String)"
                cell2.lblPrice2.text = "$\(amount)"
                return cell2
            }

        
   
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 1 {
        return 300
    } else {
        return UITableView.automaticDimension
      }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 300
        } else {
            return UITableView.automaticDimension
        }
    }
}
