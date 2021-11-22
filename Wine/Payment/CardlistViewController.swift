//
//  CardlistViewController.swift
//  Wine
//
//  Created by Apple on 02/08/21.
//

import UIKit
import Stripe
import Alamofire
class CardlistViewController: UIViewController,STPAddCardViewControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var addnewbtn: UIButton!
    @IBOutlet weak var titletext_lbl: UILabel!
    
    @IBOutlet weak var btnshowamount: UIButton!
    @IBOutlet weak var child_tabl: UITableView!
    @IBOutlet var child_view: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tbl_hight: NSLayoutConstraint!
    
    @IBOutlet weak var teamheading_lbl: UILabel!
    @IBOutlet weak var topshadow_View: UIView!
    @IBOutlet weak var done_btn: UIButton!
    @IBOutlet weak var Pyment_tbl: UITableView!
 
    var amountcheck :Double!
    var WallAmount :Double!
    var Selected_DictCell = NSMutableDictionary()
   
    var cardListarr : NSMutableArray = NSMutableArray()
    var card_id : NSMutableArray = NSMutableArray()
    var selectedIndexPath : IndexPath!
    var paymentdic = NSDictionary()
    var chekboox = ""
    var idList: NSMutableArray = NSMutableArray()
   
    var Paywithwallate = ""
    var chrID = ""
    var join_amountteam = ""
    var walletamount = ""
    var withdrawal_account = ""
    
    var isBack = true
    
    
    var cardID_str = ""
    
    var dic_CurrectAddress = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Pyment_tbl.separatorInset = UIEdgeInsets.zero
        self.Pyment_tbl.tableFooterView = UIView(frame: CGRect.zero)
        let defaults = UserDefaults.standard
        
//        if (defaults.string(forKey: "cust_id") != nil) {
//            tbl_hight.constant = CGFloat(0)
//        }else {
//            tbl_hight.constant = CGFloat(0)
//            Pyment_tbl.isHidden = true
//            titletext_lbl.text = "No Saved Payment Method Found"
//            addnewbtn.isEnabled = true
//        }
        let path =  UIBezierPath(roundedRect:  teamheading_lbl.frame, byRoundingCorners: ([.topLeft, .topRight]), cornerRadii: CGSize(width: 11.0, height: 11.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        teamheading_lbl.layer.mask = maskLayer
        //  self.roundCorners(view: topshadow_View, corners: [.bottomLeft, .bottomRight], radius: 12.0)
        
        self.child_view.frame = self.view.bounds
        self.view.addSubview(self.child_view)
        self.child_view.isHidden = true
      
        
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
            getCardlist_API()
            }

    
    }
    //MARK:- Corner Radius of only two side of UIViews
    func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedIndexPath = nil
        let defaults = UserDefaults.standard
    
        
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
            getCardlist_API()
            }
        
        if (defaults.string(forKey: "cust_id") != nil) {
            addnewbtn.isEnabled = false
            getCardlist_API()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
    }
    override func viewDidLayoutSubviews() {
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: (addnewbtn.frame.origin.y+addnewbtn.frame.size.height+20))
    }
    /**************************************************************************/
    //MARK:- TableView ///////
    /**************************************************************************/
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return cardListarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
            let cell = Pyment_tbl.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PaymentCell
            let dict = cardListarr.object(at: indexPath.row) as! NSDictionary

        print(dict)
        
            let brand = dict.object(forKey: "brand") as? String
           // cell.brand_lbl.text   = brand!.capitalizingFirstLetter()
        let cardname  = (dict.object(forKey: "brand") as? String)?.lowercased()
      
        cell.brand_lbl.text = brand
        cell.card_lbl.text   =  "**********" + (dict.object(forKey: "last4") as? String ?? "")
        cell.img?.image = UIImage(named: cardname!)
        cell.include_lbl.isHidden = true
        
            
            if selectedIndexPath != nil && selectedIndexPath == indexPath {
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                cell.tintColor = (UIColor(red: 54.0/255.0, green: 59.0/255.0, blue: 82.0/255.0, alpha: 1.0))
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }

            cell.contentView.layer.cornerRadius = 6.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            cell.contentView.layer.masksToBounds = true;

            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false;
            cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
          

        cell.Switch_OnOff.tag = indexPath.row
        cell.Switch_OnOff.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        
        if dict.GotValue(key: "IsSelected") as String == "YES" {
        
            cell.Switch_OnOff.setOn(true, animated: false)
            
        } else {
            
            cell.Switch_OnOff.setOn(false, animated: false)
        }
        
        
        return cell
    }
    
    // MARK: - UITableView delegates
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
            // cell.backgroundColor = UIColor.white
        }
        
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
            //cell.backgroundColor = UIColor.white
        }
        
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
            //cell.backgroundColor = UIColor.white
        }
        //declaring the cell variable again
        
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//
//        return CGFloat(cardListarr.count);
//
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer_view = UIView()
        footer_view.backgroundColor = UIColor.white
        return footer_view
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
        
       
        
        if let dict = cardListarr.object(at: indexPath.row) as? NSDictionary {
            
            print(dict)
            let cardid = (dict.GotValue(key: "id") as String)
            removeCard(cardId: cardid)
            print(cardid)
        }
        
        
    }
    @objc func switchStateDidChange(_ sender:UISwitch) {
        
//        print("Selected Tag : \(sender.tag)")
        
        cardListarr.setValue("NO", forKey: "IsSelected")
        if let dict: NSDictionary = cardListarr.object(at: sender.tag) as? NSDictionary {
            if (sender.isOn == true) {
                dict.setValue("YES", forKey: "IsSelected")
            } else {
                cardID_str = ""
                dict.setValue("NO", forKey: "IsSelected")
            }
        }
        
        Pyment_tbl.reloadData()
    
    }
    
    @IBAction func Addcard_action(_ sender: Any) {
        var cardiStr = ""
        if cardListarr.count > 0{
            for i in cardListarr{
                let dict = i as! NSDictionary
                if dict["IsSelected"] as! String == "YES"{
                    let cardid = (dict.GotValue(key: "id") as String)
                    cardiStr = cardid
                }else{
                    
                }
            }
            
        }
        if cardiStr.isEmpty == true{
            ShowCustomAlert.show(withMessage:"Please select account to proceed for payment")
        }else{
        
        let nextPage = self.storyboard?.instantiateViewController(withIdentifier: "ReceiptViewController") as! ReceiptViewController
            nextPage.cardID_str = cardiStr
        
            nextPage.shippind_Dic = dic_CurrectAddress
            
        self.navigationController?.pushViewController(nextPage, animated: false)
        }
    }
    
    
    @IBAction func Actionon_done(_ sender: Any) {
        let nextpage = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        
        self.navigationController?.pushViewController(nextpage, animated: true)
    }
    //MARK:- STPAdd Card Controller Delegate
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
        dismiss(animated: true, completion: nil)
    }
    @objc func pay() {
        
    }
    @IBAction func ActiononBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)
    }
    
    @IBAction func addCard(_ sender: Any) {
        let nextpage = self.storyboard?.instantiateViewController(withIdentifier: "AddCard_VC") as! AddCard_VC
        
        self.navigationController?.pushViewController(nextpage, animated: true)
    }
    
    
    //MARK:-  ApI Call get card list///
    /**************************************************************************/
    func getCardlist_API() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        var email = Userdetails["useremail"] as? String ?? ""
        let parameters: Parameters = ["useremail" : email]
        let urlString = getPaymentCardlist
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.getCardlistAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.getCardlistAPICallError(error)
            }
        }
    }
    
    func getCardlistAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as! NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
       // print(dictPlayersInfo)
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
          
            let userdata = data["Cardlist"] as! NSDictionary ?? [:]
            let cardlist = userdata["data"] as! NSArray 
            cardListarr = NSMutableArray()
            for i in cardlist{
                if let dict: NSDictionary = i as? NSDictionary {
                    let localDict = NSMutableDictionary(dictionary: dict)
                    cardListarr.add(localDict)
                }
            }
            
            cardListarr.setValue("NO", forKey: "IsSelected")
            print(cardListarr)
            
                 
            if  cardListarr.count == 0{
                                tbl_hight.constant = CGFloat(0)
                            Pyment_tbl.isHidden = true
                            titletext_lbl.text = "No Saved Payment Method Found"
                            addnewbtn.isEnabled = true
    
            }else{
                Pyment_tbl.isHidden = false
                tbl_hight.constant = CGFloat(68*cardListarr.count) + CGFloat(5*cardListarr.count-1)
                titletext_lbl.text =  "Please select any one card to pay"
            }
            Pyment_tbl.reloadData()
            
        }else{
            ShowCustomAlert.show(withMessage:message)
            if  cardListarr.count == 0{
                       tbl_hight.constant = CGFloat(0)
                       Pyment_tbl.isHidden = true
                       titletext_lbl.text = "No Saved Payment Method Found"
                       addnewbtn.isEnabled = true
            }else{
                Pyment_tbl.isHidden = false
                titletext_lbl.text =  "Please select any one card to pay"
                tbl_hight.constant = CGFloat(68*cardListarr.count) + CGFloat(5*cardListarr.count-1)
            }
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }
    func getCardlistAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
  
    //MARK:-  ApI Call///
    /**************************************************************************/
    
    func removeCard(cardId : String)
    {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        var email = Userdetails["useremail"] as? String ?? ""
        let parameters: Parameters = ["useremail" : email, "cardId" : cardId]
        let urlString = deleteCard
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.removeCardAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.removeCardAPICallError(error)
            }
        }
        
    }
    
    
    func removeCardAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
       getCardlist_API()
    }
 
    func removeCardAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage:"Internet is not responding. Please check the connection")

    }
    

    
    @IBAction func Actionon_Cancel(_ sender: Any) {
     
        idList.removeAllObjects()
        self.child_tabl.reloadData()
        self.child_view.isHidden = true
        
    }
    
    @IBAction func Actionon_selcted_pay(_ sender: Any) {
      //  print(idList)
        
        
        
        if idList.count > 0 {
            if Paywithwallate == "PayWallte"{
               
                let Wamount = Double(walletamount)
                let afetWallAmount = Double(join_amountteam)
              //  print(Wamount)
              //  print(afetWallAmount)
               
                
                 if Wamount! >= afetWallAmount!{
                //    self.objpayalllistBL.delegate = self

              
                    

                }else {

                    ShowCustomAlert.show(withMessage:"Your wallet balance is low, please pay with a card. Thank you")
                }
               // WallAmount
            }else {
              //  self.objpayalllistBL.delegate = self
               // self.Paymetandconfapi()
            }
           
            
        }else{
            ShowCustomAlert.show(withMessage:"Please select account to proceed for payment")
        }
        
        
    }
    
    /**************************************************************************/
    //MARK:-  ApI Call///
    /**************************************************************************/
    
}
