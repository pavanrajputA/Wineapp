//
//  ShippingDetailsViewController.swift
//  Wine
//
//  Created by Apple on 02/08/21.
//

import UIKit
import Alamofire

class ShippingDetailsViewController: UIViewController,UITextFieldDelegate ,UIPickerViewDelegate,UIPickerViewDataSource{
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
  
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtAddress1: UITextField!
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    
    @IBOutlet weak var btnAddbutton: UIButton!
    @IBOutlet weak var txtSelectTypeforStoer: CustomUITextField!

    var pickerData = ["Delivery Wine Patner","Pick To Store"]
    var selectedRow = 0;
    
    var wherefrom = ""
    
    var isBack = true
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.layer.borderWidth = 1
        view1.layer.borderColor = UIColor.lightGray.cgColor
        view2.layer.borderWidth = 1
        view2.layer.borderColor = UIColor.lightGray.cgColor
    
        
        view4.layer.borderWidth = 1
        view4.layer.borderColor = UIColor.lightGray.cgColor
        view5.layer.borderWidth = 1
        view5.layer.borderColor = UIColor.lightGray.cgColor
        view6.layer.borderWidth = 1
        view6.layer.borderColor = UIColor.lightGray.cgColor
        view7.layer.borderWidth = 1
        view7.layer.borderColor = UIColor.lightGray.cgColor
        view8.layer.borderWidth = 1
        view8.layer.borderColor = UIColor.lightGray.cgColor
        
        
        txtFullName.delegate = self
        txtAddress1.delegate = self
        txtAddress2.delegate = self
        txtCity.delegate = self
        txtState.delegate = self
        txtZip.delegate = self
        txtSelectTypeforStoer.delegate = self
//        let userDefaults = UserDefaults.standard
//        let shippind_Dic = userDefaults.object(forKey: "shippingDetails") as? NSDictionary ?? [:]
//        print(shippind_Dic)
//
//
//        if shippind_Dic["zip"] as? String ?? "" == ""{
//            btnAddbutton.setTitle("Add", for: .normal)
//        }else{
//            btnAddbutton.setTitle("Update", for: .normal)
//        }
//
//        txtFullName.text = shippind_Dic["fullname"] as? String ?? ""
//        txtAddress1.text = shippind_Dic["address1"] as? String ?? ""
//        txtAddress2.text = shippind_Dic["address2"] as? String ?? ""
//        txtCity.text = shippind_Dic["city"] as? String ?? ""
//        txtState.text = shippind_Dic["state"] as? String ?? ""
//        txtZip.text = shippind_Dic["zip"] as? String ?? ""
        addDoneButtonOnKeyboard()
        PikerButtonOnKeyboard()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        if APPDELEGATE.isBack == true {
            self.navigationController?.popToRoot(animated: false)
            APPDELEGATE.isBack = false
        }else{
            APPDELEGATE.isBack = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

//        let textTag = textField.tag+1
//        if let nextResponder = textField.superview?.viewWithTag(textTag)!
//        {
//            //textField.resignFirstResponder()
//            nextResponder.becomeFirstResponder()
//        }
       
            // stop editing on pressing the done button on the last text field.

            self.view.endEditing(true)
      //  }
        return true
    }

    
    @IBAction func btnBack(_ sender: Any) {
        
        if wherefrom == "Login"{
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
              self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        }else if wherefrom == "Signup"{
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
              self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
        }
        else{
            self.navigationController?.pop(animated: true)
        }
        isBack = true
    }
    
    @IBAction func btnContinue(_ sender: Any) {

        
        if txtFullName.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter Full Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }else if txtAddress1.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter Address1", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }else if txtCity.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message:  "Enter City Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }else if txtState.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message:  "Enter State", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }
        else if txtZip.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message:  "Enter Zip Code", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }
        else {
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
                    shipingDetailsupdateAPIOnly()
                    }
            }
    }
    @IBAction func btnNext(_ sender: Any) {
        
        
        if txtFullName.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter Full Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }else if txtAddress1.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter Address1", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }else if txtCity.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message:  "Enter City Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }else if txtState.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message:  "Enter State", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }
        else if txtZip.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message:  "Enter Zip Code", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }
        else {
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
                    
                    let userDefaults = UserDefaults.standard
                    let shippind_Dic = userDefaults.object(forKey: "shippingDetails") as? NSDictionary ?? [:]
                    print(shippind_Dic)
                    
                    if shippind_Dic["zip"] as? String ?? "" == ""{
                        ShowCustomAlert.showCenter(withMessage: "Please add the shipping details")
                    }else{
                    
                    let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "CardlistViewController") as! CardlistViewController
                   // editProfile.dicDetails = dict! as NSDictionary
                    
                    self.navigationController?.pushViewController(editProfile, animated: false)
                    }
                    }
            }
    }
    
    // MARK: - Done text file method
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(LoginViewController.doneButtonAction))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        txtFullName.inputAccessoryView = doneToolbar
        txtAddress1.inputAccessoryView = doneToolbar
        txtAddress2.inputAccessoryView = doneToolbar
        txtCity.inputAccessoryView = doneToolbar
        txtState.inputAccessoryView = doneToolbar
        txtZip.inputAccessoryView = doneToolbar
    }
    
    
        @objc func doneButtonAction()
        {
            txtFullName.resignFirstResponder();
            txtAddress1.resignFirstResponder();
            txtAddress2.resignFirstResponder();
            txtCity.resignFirstResponder();
            txtState.resignFirstResponder();
            txtZip.resignFirstResponder();
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
    
    
    /**************************************************************************/
    //MARK:-  ApI Call///
    /**************************************************************************/
    
    func shipingDetailsupdateAPIOnly()
    { // local video file path..
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        txtFullName.resignFirstResponder();
        txtAddress1.resignFirstResponder();
        txtAddress2.resignFirstResponder();
        txtCity.resignFirstResponder();
        txtState.resignFirstResponder();
        txtZip.resignFirstResponder();
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        print(Userdetails)
        
        var email = Userdetails["useremail"] as? String ?? ""
        
        let parameters: Parameters = ["fullname" : txtFullName.text!, "address1" : txtAddress1.text!,"address2" : txtAddress2.text!, "city" : txtCity.text!,"zip" : txtZip.text!, "state" : txtState.text!, "useremail" : email]
      //  let urlString = shipingDetailsUpdate
        
        let urlString = newshipingDetailsAdd
        let url = URL.init(string: urlString)
        
        print(parameters)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                        switch response.result
                       {
                       case .success(let json):
                           let jsonData = json as! Any
                           print(jsonData)
               self.ShipindDetailsAPICallFinished(json as! NSDictionary)
                       case .failure(let error):
                           self.ShipindDetailsAPICallError(error)
                       }
        }
    }
    
    func ShipindDetailsAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["shippingDetails"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let userdata = data as! NSDictionary
//            let userDefaults = UserDefaults.standard
//
//            userDefaults.set(userdata, forKey: "shippingDetails")
//            let shippind_Dic = userDefaults.object(forKey: "shippingDetails") as? NSDictionary ?? [:]
//            if shippind_Dic["zip"] as? String ?? "" == ""{
//                ShowCustomAlert.showCenter(withMessage: "Please add the shipping details")
//            }else{
//
//                if wherefrom == "Login"{
//                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//                      self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
//                }else if wherefrom == "Signup"{
//                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//                      self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
//                }
//                else{
//                    self.navigationController?.pop(animated: true)
//                }
//                isBack = true
//            }
            if wherefrom == "Login"{
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                  self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            }else if wherefrom == "Signup"{
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                  self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
            }
            else{
                self.navigationController?.pop(animated: true)
            }
            isBack = true
                    
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
       
    }
    func ShipindDetailsAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
    
    
}
class CustomUITextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}
