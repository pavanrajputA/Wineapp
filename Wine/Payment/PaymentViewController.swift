//
//  PaymentViewController.swift
//  Wine
//
//  Created by Apple on 04/08/21.
//

import UIKit
import Alamofire
class PaymentViewController: UIViewController {
    
    
    var cardID_str = ""
    var isBack = true
    
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblShiping: UILabel!
    @IBOutlet weak var lblStatetax: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    var paymentId_str = ""
    
    var totalAmount = ""
    
    var arrList : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        let email = Userdetails["useremail"] as? String ?? ""
        let parameters: Parameters = ["useremail" : email]
        // Do any additional setup after loading the view.
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if APPDELEGATE.isBack == true {
            self.navigationController?.popToRoot(animated: false)
            APPDELEGATE.isBack = false
        }else{
            APPDELEGATE.isBack = false
        }
        
    }
    
    @IBAction func btnPayment(_ sender: Any) {
        
        if lblTotal.text?.isEmpty == true{
            
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
            SendPaymentStatus_API()
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.showCenter(withMessage: message)
 
    }
    func paymentAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    //MARK:-  ApI Call get card list///
    /**************************************************************************/
    func getIFoItim_API() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        var email = Userdetails["useremail"] as? String ?? ""
 
        let shippind_Dic = userDefaults.object(forKey: "shippingDetails") as? NSDictionary ?? [:]
        print(shippind_Dic)
        let parameters: Parameters = ["useremail" : email, "listitme" : arrList as! NSArray, "stateRate" : "\(shippind_Dic["state_rate"] as! Double)"]
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
        let data = dictPlayersInfo["data"] as! NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let userdata = data as! NSDictionary
            print(userdata)
            
            let subTotal = userdata["subTotal"] as! NSString
            let Shiping = userdata["shippingCharge"] as! NSNumber
            let Statetax = userdata["stateRate"] as! NSString
            
            let paymentId = userdata.GotValue(key: "paymentId") as! String
            paymentId_str = paymentId
            lblSubtotal.text = "$\(subTotal)"
            lblShiping.text = "$\(Shiping)"
            lblStatetax.text = "$\(Statetax)"
        
            
            let subTotalFlot = Float(subTotal as Substring)
                
            let ShipingFlot = Float(truncating: Shiping)
            let StatetaxFlot = Float(Statetax as Substring)

            let totalPrice = subTotalFlot! + ShipingFlot + StatetaxFlot!
           
            totalAmount = String(format: "%.2f", totalPrice)
            lblTotal.text = "$\(totalAmount)"
                     
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
    
    
    
    
    //MARK:-  ApI Call patmentnt suceess api///
    /**************************************************************************/
    func SendPaymentStatus_API() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
          let parameters: Parameters = ["status" : true, "paymentId" : paymentId_str]
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
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ThanksuViewController") as! ThanksuViewController
            var arrlocl : NSMutableArray = NSMutableArray()
            let userDefaults = UserDefaults.standard
            userDefaults.set(arrlocl, forKey: "userproductdata")
          //  ShowCustomAlert.showCenter(withMessage: message)

            self.navigationController?.pushViewController(editProfile, animated: false)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
 
    }
    func SendPaymentStatusAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    

}
