//
//  BagViewController.swift
//  Wine
//
//  Created by Apple on 29/07/21.
//

import UIKit
import Alamofire

class BagViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblView_hight: NSLayoutConstraint!
    @IBOutlet weak var scrollview_hight: NSLayoutConstraint!
    @IBOutlet weak var tblAddress_hight: NSLayoutConstraint!
    @IBOutlet weak var viewmain_hight: NSLayoutConstraint!
    @IBOutlet weak var tblViewForAddress: UITableView!
    var arrList: NSMutableArray = NSMutableArray()
    var arrListAddress: NSMutableArray = NSMutableArray()
    var userDefaults = UserDefaults.standard
    
    ///
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var lblShippingAddress: UILabel!
    
    @IBOutlet weak var lblNodatafound: UILabel!
    
    @IBOutlet weak var txtSelectTypeforStoer: CustomUITextField!
    var pickerData = ["Ship To Address","Pick up in Store"]
    var selectedRow = 0;
    
    var numberCount = 0
    var dic1 = NSMutableDictionary()
    var dic2 = NSMutableDictionary()
    var dic3 = NSMutableDictionary()
    
    var dublSubToal = 0.0
    var dublTotal = 0.0
    var dublShipang = 0.0
    var shippingCahrge = 0.0
    var totalCount = 0
    var isBack = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = true
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "AddCardlist_TableViewCell", bundle: nil), forCellReuseIdentifier: "AddCardlist_TableViewCell")
        
        tblViewForAddress.delegate = self
        tblViewForAddress.dataSource = self
        tblViewForAddress.separatorStyle = .none
        tblViewForAddress.isScrollEnabled = true
        tblViewForAddress.backgroundColor = .clear
        tblViewForAddress.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
        
        showDetails()
        
        btnCheckout.layer.cornerRadius = 20
        
        view1.layer.borderWidth = 2
        view1.layer.borderColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        view1.layer.cornerRadius = 5
        view2.layer.borderWidth = 2
        view2.layer.borderColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        view2.layer.cornerRadius = 5
        
        txtSelectTypeforStoer.delegate = self
        PikerButtonOnKeyboard()
    }
    override func viewDidAppear(_ animated: Bool) {
        if APPDELEGATE.isBack == true {
            self.navigationController?.popToRoot(animated: false)
            APPDELEGATE.isBack = false
        }else{
            APPDELEGATE.isBack = false
        }
      
        
        let islogin = UserDefaults.standard.string(forKey: "Islogin")
    
    if islogin == "YES"{
        
//        let userDefaults = UserDefaults.standard
//        let shippind_Dic = userDefaults.object(forKey: "shippingDetails") as? NSDictionary ?? [:]
//        print(shippind_Dic)
//        if shippind_Dic["zip"] as? String ?? "" == ""{
//            lblShippingAddress.text =  "Add New Address"
//        }else{
//            lblShippingAddress.text =  "Add New Address"
//        }
        lblShippingAddress.text =  "Add New Address"
       
        
        
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
            addresslist_API()
            }
        
    }else{
      
    }
        
    }
    override func viewDidLayoutSubviews(){
        tblView.reloadData()
        
    }
    // MARK: - picker in list delegets
    
    func PikerButtonOnKeyboard()
    {
        let countryPickerView = UIPickerView()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.showsSelectionIndicator = true
        countryPickerView.backgroundColor = UIColor.gray
        countryPickerView.selectRow(256, inComponent: 0, animated: true)
        countryPickerView.tag = 1
        //set  default country in textfiled
        
        /* Creating custom done button on top of keyboard*/
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toolBar.backgroundColor = #colorLiteral(red: 0.5634852052, green: 0, blue: 0.106474109, alpha: 1)
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(self.canclePicker))
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtSelectTypeforStoer.inputView = countryPickerView
        txtSelectTypeforStoer.inputAccessoryView = toolBar
        
        
    }
    @objc func donePicker() {
        if pickerData.count > 0 {
            self.txtSelectTypeforStoer.text = pickerData[selectedRow]
            txtSelectTypeforStoer.resignFirstResponder()
        }else{
            
            txtSelectTypeforStoer.resignFirstResponder()
            
            let alert = UIAlertController(title: "", message: NSLocalizedString("Please select card name.", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "OK", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }
    }
    
    @objc func canclePicker() {
        txtSelectTypeforStoer.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if (pickerView.tag == 1){
            return pickerData.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if (pickerView.tag == 1){
            // selectedRow = row;
            let name =  pickerData[row]
            return NSAttributedString(string: name , attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        }
        return NSAttributedString(string: "" , attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            //selectedRow = row;
            let name = pickerData[row]
            return name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (pickerView.tag == 1){
            selectedRow = row;
            let name =  pickerData[row]
        }
    }
    
    
    
    func showDetails(){
        
        arrList = NSMutableArray()
        let localcall = UserDefaults.standard.object(forKey: "userproductdata") as? NSArray ?? []
        for i in localcall{
            var itmedata = i as! NSDictionary
            arrList.add(itmedata)
        }
        for i in arrList{
            var itmedata = i as! NSDictionary
            var price = itmedata["prize"] as! NSNumber
            var count = itmedata["count"] as! NSNumber
            totalCount = totalCount + Int(count)
            var totl = Double(exactly: price)! * Double(count)
            dublSubToal += totl
        }
        var price = dublSubToal
      
        if totalCount == 0{
            shippingCahrge = 0.0
            
        }
       else if totalCount < 4{
        shippingCahrge = 15.0

        }else if totalCount < 7{
            shippingCahrge = 30.0

        }else if totalCount < 12{
            shippingCahrge = 35.0

        }else if totalCount < 100{
            shippingCahrge = 0.0

        }else{
            shippingCahrge = 0.0

        }
        
       
        
        dublTotal = shippingCahrge + price
        
        
       // lblTotalprice.text = String(format: "%.2f", dublTotal)
        tblView_hight.constant = CGFloat(80*arrList.count) + CGFloat(5*arrList.count-1)
        //tblAddress_hight.constant = CGFloat(100*arrList.count) + CGFloat(5*arrList.count-1)
        viewmain_hight.constant = tblView_hight.constant + tblAddress_hight.constant + 200
        tblView.reloadData()
        tblView.layoutIfNeeded()
    
        if arrList.count == 0{
            lblNodatafound.isHidden = false
            tblView_hight.constant = 200
    
            scrollview_hight.constant = viewmain_hight.constant
        }else{
            lblNodatafound.isHidden = true
            scrollview_hight.constant = viewmain_hight.constant
        }
        
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    @IBAction func btnAddAddress(_ sender: Any) {
        let islogin = UserDefaults.standard.string(forKey: "Islogin")
    
    if islogin == "YES"{
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ShippingDetailsViewController") as! ShippingDetailsViewController
        self.navigationController?.pushViewController(editProfile, animated: false)
    }else{
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        // editProfile.dicDetails = dict! as NSDictionary
        editProfile.selectType = "Bag"
        self.navigationController?.pushViewController(editProfile, animated: false)
    }
    }
    @IBAction func btnCheckout(_ sender: Any) {
        
        if arrList.count == 0{
            ShowCustomAlert.showCenter(withMessage: "There is nothing in your bag. Let's add some items")
        } else if "lblShippingType.text" == "Pick up in Store"{
            ShowCustomAlert.showCenter(withMessage: "Currently not available Pickup in Store facility Please choose another one" )
        }
        else{
            let islogin = UserDefaults.standard.string(forKey: "Islogin")
        
        if islogin == "YES"{
            
            
            
            
//            let userDefaults = UserDefaults.standard
//            let shippind_Dic = userDefaults.object(forKey: "shippingDetails") as? NSDictionary ?? [:]
//            print(shippind_Dic)
           // shippind_Dic["zip"] as? String ?? "" == ""
            if arrListAddress.count == 0{
               // btnAddbutton.setTitle("Add", for: .normal)
                ShowCustomAlert.showCenter(withMessage: "Currently not available shipping address please add" )
            }else if txtSelectTypeforStoer.text == ""{
                ShowCustomAlert.showCenter(withMessage: "Select Delivery type" )
            }else if txtSelectTypeforStoer.text == "Pick up in Store"{
                ShowCustomAlert.showCenter(withMessage: "Currently not Unavailable \'Pick up in Store'")
            }
            else{
                
                var Dic_Address = NSDictionary()
                if arrListAddress.count > 0{
                    for i in arrListAddress{
                        let dict = i as! NSDictionary
                        if dict["IsSelected"] as! String == "YES"{
                            Dic_Address = dict
                        }else{
                            
                        }
                    }
                    
                }
                if Dic_Address.isEqual(to: [ : ]) == true{
                    ShowCustomAlert.show(withMessage:"Please select shipping address")
                }else{
                
                let nextPage = self.storyboard?.instantiateViewController(withIdentifier: "CardlistViewController") as! CardlistViewController
                    nextPage.dic_CurrectAddress = Dic_Address
                
                self.navigationController?.pushViewController(nextPage, animated: false)
                }
                
//                let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "CardlistViewController") as! CardlistViewController
//                self.navigationController?.pushViewController(editProfile, animated: false)
            }
      
        }else{
//            let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            // editProfile.dicDetails = dict! as NSDictionary
//            editProfile.selectType = "Bag"
//            self.navigationController?.pushViewController(editProfile, animated: false)
        }
            
        }
    }
   
    
    
    /**************************************************************************/
    //MARK:-  ApI Call socialLogin///
    /**************************************************************************/
    func addresslist_API() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        var email = Userdetails["useremail"] as? String ?? ""
        
        let parameters: Parameters = [ "useremail" : email]
        let urlString = listofaddress
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.addresslistAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.addresslistAPICallError(error)
            }
        }
    }
    func addresslistAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let userdata = data!["list"] as! NSArray
            arrListAddress = NSMutableArray()
            
            
            for i in userdata{
                if let dict: NSDictionary = i as? NSDictionary {
                    let localDict = NSMutableDictionary(dictionary: dict)
                    arrListAddress.add(localDict)
                }
            }
            
            arrListAddress.setValue("NO", forKey: "IsSelected")
            
            tblViewForAddress.reloadData()
        }else{
            arrListAddress = NSMutableArray()
            tblViewForAddress.reloadData()
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
    }
    func addresslistAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
  
    
    /**************************************************************************/
    //MARK:-  ApI Call socialLogin///
    /**************************************************************************/
    func deleteAddress_API(cardId : NSNumber) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        var email = Userdetails["useremail"] as? String ?? ""
        
        let parameters: Parameters = ["addressId": "\(cardId)"]
        let urlString = deleteaddress
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.deleteAddressAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.deleteAddressAPICallError(error)
            }
        }
    }
    func deleteAddressAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            addresslist_API()
           // tblViewForAddress.reloadData()
            
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
    }
    func deleteAddressAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
}
extension BagViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblView{
            return arrList.count
        }else{
            return arrListAddress.count
        }
    
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == tblView{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardlist_TableViewCell", for: indexPath) as? AddCardlist_TableViewCell else { return UITableViewCell() }
        
        cell.btnPluse.tag = indexPath.row
        cell.btnPluse.addTarget(self, action: #selector(btnPluse(sender:)), for: .touchUpInside)
        
        
        cell.btnMinice.tag = indexPath.row
        cell.btnMinice.addTarget(self, action: #selector(btnMinus(sender:)), for: .touchUpInside)
        
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(btnDelete(sender:)), for: .touchUpInside)
        
        let dict = arrList.object(at: indexPath.row) as? NSDictionary
        
        cell.lblName.text = "\(dict!.GotValue(key: "name") as String)"
        cell.lblCount.text = "\(dict!.GotValue(key: "count") as String)"
        cell.lblPrice.text = "$\(dict!.GotValue(key: "prize") as String)"
        
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
            
        cell.imageWine.sd_setShowActivityIndicatorView(true)
        cell.imageWine.sd_setIndicatorStyle(.gray)
        cell.imageWine?.sd_setImage(with: imageUrl) { [self] (image, error, cache, urls) in
            if (error != nil) {
                cell.imageWine.image = #imageLiteral(resourceName: "4")
                cell.imageWine.sd_setShowActivityIndicatorView(false)
            } else {
                cell.imageWine.image = image
                cell.imageWine.sd_setShowActivityIndicatorView(false)
            }
        }
        
        
        return cell
        }else{
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as? AddressTableViewCell else { return UITableViewCell() }
            let dict2 = arrListAddress.object(at: indexPath.row) as? NSDictionary
            
            cell2.btnIsSelected.tag = indexPath.row
            cell2.btnIsSelected.addTarget(self, action: #selector(self.selectButton(_:)), for: .touchUpInside)
  
            cell2.btnDelete.tag = indexPath.row
            cell2.btnDelete.addTarget(self, action: #selector(DeleteButton(sender:)), for: .touchUpInside)
            
            
            cell2.lblFullName.text = "Name- \(dict2!["fullname"] as? String ?? "")"
            cell2.lblAddress1.text = "Address- \(dict2!["address1"] as? String ?? "")"
            cell2.lblCity.text = "City- \(dict2!["city"] as? String ?? "")"
            cell2.lblState.text = "State- \(dict2!["state"] as? String ?? "")"
            cell2.lblZip.text = "ZIP- \(dict2!["zip"] as? String ?? "")"

            
            if dict2!.GotValue(key: "IsSelected") as String == "YES" {
            
//                cell2.btnIsSelected.setOn(true, animated: false)
                cell2.imageselecte.image = UIImage(systemName: "dot.circle.fill")
            } else {
                
                cell2.imageselecte.image = UIImage(systemName: "circle")
            }
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if tableView == tblView {
        return 80
    } else {
        return UITableView.automaticDimension
      }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblView {
            return 80
        } else {
            return UITableView.automaticDimension
        }
    }
    
    @objc func selectButton(_ sender:UIButton) {
                
        arrListAddress.setValue("NO", forKey: "IsSelected")
        if let dict: NSDictionary = arrListAddress.object(at: sender.tag) as? NSDictionary {
            
            if dict["IsSelected"] as! String == "YES"{
                dict.setValue("NO", forKey: "IsSelected")
            }else if dict["IsSelected"] as! String == "NO"{
                dict.setValue("YES", forKey: "IsSelected")
            }
                else{
                dict.setValue("NO", forKey: "IsSelected")
            }
        }
        tblViewForAddress.reloadData()
    
    }
    @objc func DeleteButton(sender: UIButton) {
           
        print(sender.tag)
        if let dict: NSDictionary = arrListAddress.object(at: sender.tag) as? NSDictionary {
            
            let buttonTag = sender.tag
            let dict = arrListAddress.object(at: buttonTag) as? NSDictionary
            var ID = dict!["addressId"] as! NSNumber
            
            deleteAddress_API(cardId: ID)
        }
        tblViewForAddress.reloadData()
    
    }
    
    @objc func btnPluse(sender: UIButton){
        let buttonTag = sender.tag
        let dict = arrList.object(at: buttonTag) as? NSDictionary
        var count = dict!["count"] as! NSNumber
        // arrList.remove(dict)
        numberCount = Int(count)
        numberCount += 1
        
        if numberCount == 37{
            numberCount = 36
        }
        else if numberCount == 36{
        }
        else{
        }
        
        //  var dicNewdata: NSDictionary = ["Imagename": dict!["image"] as! String ,"price": dict!["price"] as! String,"name" : dict!["name"] as! String,"count" : numberCount]
        
        var dicNewdata: NSDictionary =  ["id" : dict!["id"] as! NSNumber,"image": dict!["image"] as! String ,"prize": dict!["prize"] as! Double,"name" : dict!["name"] as! String,"count" : numberCount]
        
        arrList.replaceObject(at: buttonTag, with: dicNewdata)
        totalCount = 0
        dublSubToal = 0.0
        for i in arrList{
            var itmedata = i as! NSDictionary
            var price = itmedata["prize"] as! NSNumber
            var count = itmedata["count"] as! NSNumber
            var totl = Double(exactly: price)! * Double(count)
            
            totalCount = totalCount + Int(count)
            
            dublSubToal += totl
        }
        print(totalCount)
        
        print(dublSubToal)
        var price = dublSubToal
    
        if totalCount == 0{
            shippingCahrge = 0.0
        }
       else if totalCount < 4{
        shippingCahrge = 15.0

        }else if totalCount < 7{
            shippingCahrge = 30.0

        }else if totalCount < 12{
            shippingCahrge = 35.0

        }else if totalCount < 100{
            shippingCahrge = 0.0

        }else{
            shippingCahrge = 0.0

        }
        
        
      
        
        dublTotal = shippingCahrge + price
    
        userDefaults.set(arrList, forKey: "userproductdata")
        tblView.reloadData()
        
        if arrList.count == 0{
            lblNodatafound.isHidden = false
        }else{
            lblNodatafound.isHidden = true
        }
        
    }
    @objc func btnMinus(sender: UIButton){
        let buttonTag = sender.tag
        let dict = arrList.object(at: buttonTag) as? NSDictionary
        var count = dict!["count"] as! NSNumber
        
        print(count)
        totalCount = 0
        numberCount = Int(count)
        // arrList.remove(dict)
        numberCount -= 1
        if numberCount == 0{
            numberCount = 1
        }

        var dicNewdata: NSDictionary =  ["id" :  dict!["id"] as! NSNumber,"image": dict!["image"] as! String ,"prize": dict!["prize"] as! Double,"name" : dict!["name"] as! String,"count" : numberCount]
        
        arrList.replaceObject(at: buttonTag, with: dicNewdata)
        
        dublSubToal = 0.0
        for i in arrList{
            var itmedata = i as! NSDictionary
            var price = itmedata["prize"] as! Double
            var count = itmedata["count"] as! NSNumber
            var totl = Double(exactly: price)! * Double(count)
            totalCount = totalCount + Int(count)
            dublSubToal += totl
        }
        
        print(dublSubToal)
        var price = dublSubToal
    
   
        if totalCount == 0{
            shippingCahrge = 0.0
        }
       else if totalCount < 4{
        shippingCahrge = 15.0

        }else if totalCount < 7{
            shippingCahrge = 30.0

        }else if totalCount < 12{
            shippingCahrge = 35.0

        }else if totalCount < 100{
            shippingCahrge = 0.0

        }else{
            shippingCahrge = 0.0

        }
        dublTotal = shippingCahrge + price
        userDefaults.set(arrList, forKey: "userproductdata")
        tblView.reloadData()
        
        if arrList.count == 0{
            lblNodatafound.isHidden = false
        }else{
            lblNodatafound.isHidden = true
        }
    }
    @objc func btnDelete(sender: UIButton){
        let buttonTag = sender.tag
        let dict = arrList.object(at: buttonTag) as? NSDictionary
        let id = dict!["id"] as! NSNumber
        totalCount = 0
        for i in arrList{
            var itmedata = i as! NSDictionary
            var current = itmedata["id"] as! NSNumber
            if id == current{
                arrList.remove(i)
            }
        }
        dublSubToal = 0.0
        var loclArrey : NSMutableArray = NSMutableArray()
        for i in arrList{
            loclArrey.add(i as! NSDictionary)
        }
        userDefaults.set(loclArrey, forKey: "userproductdata")
        showDetails()
        
    }
    
}

 extension UIViewController {
    func localarrCount() -> Int {
        
        let localcall = UserDefaults.standard.object(forKey: "userproductdata") as? NSArray ?? []
        return localcall.count
    }

}

