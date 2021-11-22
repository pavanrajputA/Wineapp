//
//  AddCard_VC.swift
//  Streettag
//
//  Created by Apple on 14/04/20.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Stripe
import Alamofire

class AddCard_VC: UIViewController,UITextFieldDelegate,STPAddCardViewControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    var paymentdic = NSDictionary()
    var chekboox = ""
    var Card_tokenId = ""
    @IBOutlet weak var btnpay: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    let z = 4, intervalString = "-"
    let z1 = 2, intervalString1 = "/"
    @IBOutlet weak var txtCardUsername: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtMonthYear: UITextField!
    @IBOutlet weak var txtCVCnumber: UITextField!
    @IBOutlet weak var txtZipcode: UITextField!
    var pickerData = ["Visa", "Visa (debit)", "Mastercard","American Express", "Discover", "Diners Club", "JCB", "UnionPay"]
    var selectedRow = 0;
    var cardNumber = ""
    var expMonth = ""
    var expYear = ""
    var cvc = ""
    var currency = ""
    var name = ""
    var postalCode = ""
    var cardListarr : NSMutableArray = NSMutableArray()
    
    var isBack = true
    
    @IBOutlet weak var selectcardname_txt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCardNumber.delegate = self
        txtCardUsername.delegate = self
        txtMonthYear.delegate = self
        txtCVCnumber.delegate = self
        txtZipcode.delegate = self
        view1.layer.borderWidth = 1
        view1.layer.borderColor = UIColor.lightGray.cgColor
        view2.layer.borderWidth = 1
        view2.layer.borderColor = UIColor.lightGray.cgColor
        view3.layer.borderWidth = 1
        view3.layer.borderColor = UIColor.lightGray.cgColor
        view4.layer.borderWidth = 1
        view4.layer.borderColor = UIColor.lightGray.cgColor
        view5.layer.borderWidth = 1
        view5.layer.borderColor = UIColor.lightGray.cgColor
        //
        btnpay.isEnabled = true
        //  print(cardListarr.count)
        addDoneButtonOnKeyboard()
        PikerButtonOnKeyboard()
        
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
    
    override func viewDidLayoutSubviews() {
        
        //        scrollview.contentSize = CGSize(width: scrollview.frame.size.width, height: (btnpay.frame.origin.y+btnpay.frame.size.height+20))
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
    
    @IBAction func Actiononback(_ sender: Any) {
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    
    @IBAction func Actionon_Pay(_ sender: Any) {
        
        if selectcardname_txt.text?.isEmpty == true {
            
            Toast.show(message: "Select card type", controller: self)
            
        } else if txtCardNumber.text?.isEmpty == true {
            
            Toast.show(message: "Please enter card number", controller: self)
            
        } else if txtCardUsername.text?.isEmpty == true {
            
            Toast.show(message: "Please enter card holder name", controller: self)
            
        } else if (self.txtCardNumber.text!.count) <= 16 {
            
            Toast.show(message: "Please enter valid card number", controller: self)
            
        } else if txtMonthYear.text?.isEmpty == true {
            
            Toast.show(message: "Please select expiry month year", controller: self)
            
        } else if txtCVCnumber.text?.isEmpty == true {
            
            Toast.show(message: "Please enter CVV", controller: self)
            
        } else if (self.txtCVCnumber.text!.count) <= 2 {
            
            Toast.show(message: "Please enter valid CVV", controller: self)
        } else if txtZipcode.text?.isEmpty == true {
            
            Toast.show(message: "Please enter zip code", controller: self)
            
        } else {
            if self.selectcardname_txt.text == "American Express"{
                if (self.txtCVCnumber.text!.count) <= 3 {
                    Toast.show(message: "Please enter valid card number", controller: self)
                }else {
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
                        self.isCardDetailValid()
                        }
                    
                  
                }
            }else {
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
                    self.isCardDetailValid()
                    }
            }
            
        }
        txtCardUsername.resignFirstResponder();
        txtCardNumber.resignFirstResponder();
        txtMonthYear.resignFirstResponder();
        txtCVCnumber.resignFirstResponder();
        txtZipcode.resignFirstResponder();
        
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: UIBarButtonItem.Style.done, target: self, action: #selector(AddCard_VC.doneButtonAction))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        txtCardUsername.inputAccessoryView = doneToolbar
        txtCardNumber.inputAccessoryView = doneToolbar
        txtMonthYear.inputAccessoryView = doneToolbar
        txtCVCnumber.inputAccessoryView = doneToolbar
        txtZipcode.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction() {
        
        txtCardUsername.resignFirstResponder();
        txtCardNumber.resignFirstResponder();
        txtMonthYear.resignFirstResponder();
        txtCVCnumber.resignFirstResponder();
        txtZipcode.resignFirstResponder();
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtCVCnumber
        {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            var maxLength = 3
            if self.selectcardname_txt.text == "American Express"{
                maxLength = 4
            }else {
                maxLength = 3
            }
            
            let currentString: NSString = txtCVCnumber.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return (newString.length <= maxLength) && (allowedCharacters.isSuperset(of: characterSet))
            
        }
        else if textField == txtCardNumber
        {
            
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            
            
            let nsText = textField.text! as NSString
            
            if range.location == 19 { return false }
            
            if range.length == 0 && canInsert(atLocation: range.location) {
                textField.text! = textField.text! + intervalString + string
                return false
            }
            
            if range.length == 1 && canRemove(atLocation: range.location) {
                textField.text! = nsText.replacingCharacters(in: NSMakeRange(range.location-1, 2), with: "")
                return false
            }
            
            return allowedCharacters.isSuperset(of: characterSet)
            
        } else if textField == txtMonthYear {
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let nsText = textField.text! as NSString
            
            if range.location == 5 { return false }
            
            if range.length == 0 && canInsertMonth(atLocation: range.location) {
                textField.text! = textField.text! + intervalString1 + string
                return false
            }
            
            if range.length == 1 && canRemoveMonth(atLocation: range.location) {
                textField.text! = nsText.replacingCharacters(in: NSMakeRange(range.location-1, 2), with: "")
                return false
            }
            
            return allowedCharacters.isSuperset(of: characterSet)
            
        }
        else if textField == txtCardUsername{
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let Regex = "[a-z A-Z ]+"
            let predicate = NSPredicate.init(format: "SELF MATCHES %@", Regex)
            if predicate.evaluate(with: text) || string == ""
            {
                return true
            }
            else
            {
                return false
            }
        }
        else if textField == txtZipcode{
            let allowedCharacters = CharacterSet(charactersIn:"a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9")
            //Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            let maxLength = 15
            let currentString: NSString = txtZipcode.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return (newString.length <= maxLength) && (allowedCharacters.isSuperset(of: characterSet))
        }
        else
        {
            return true
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtCardUsername.resignFirstResponder();
        return true;
    }
    func canInsert(atLocation y:Int) -> Bool { return ((1 + y)%(z + 1) == 0) ? true : false }
    
    func canRemove(atLocation y:Int) -> Bool { return (y != 0) ? (y%(z + 1) == 0) : false }
    
    func canInsertMonth(atLocation y:Int) -> Bool { return ((1 + y)%(z1 + 1) == 0) ? true : false }
    
    func canRemoveMonth(atLocation y:Int) -> Bool { return (y != 0) ? (y%(z1 + 1) == 0) : false }
    
    
    func addcardandpay()  {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        cardNumber = self.txtCardNumber.text!
        btnpay.isEnabled = false
        let cardExpirddate = self.txtMonthYear.text
        let cardCVCNo = self.txtCVCnumber.text
        let zipcode =  self.txtZipcode.text
        let stripeCardParams = STPCardParams()
        stripeCardParams.number = cardNumber
        let expiryParameters = cardExpirddate?.components(separatedBy: "/")
        stripeCardParams.expMonth = UInt((expiryParameters?.first)!)!
        stripeCardParams.expYear = UInt((expiryParameters?.last)!)!
        stripeCardParams.cvc = cardCVCNo
        stripeCardParams.name = self.txtCardUsername.text
        stripeCardParams.currency = "gbp"
        stripeCardParams.address.postalCode = zipcode
        
        
        expMonth = (expiryParameters?.first)!
        expYear = (expiryParameters?.last)!
        cvc = cardCVCNo!
        let gbp = "gbp"
        currency = gbp
        name = self.txtCardUsername.text!
        postalCode = zipcode!
        // print(currency)
        //converting into token
        let config = STPPaymentConfiguration.shared
        let stpApiClient = STPAPIClient.init(configuration: config)
        stpApiClient.createToken(withCard: stripeCardParams) { (token, error) in
            
            if error == nil {
                //Success
                
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                
                //  print(token!.tokenId as Any)
                self.Card_tokenId = token!.tokenId
                DispatchQueue.main.async {
                    
                    //                    let defaults = UserDefaults.standard
                    //                    var cust_id = ""
                    //                    if (defaults.string(forKey: "cust_id") != nil) {
                    //                     //   self.objpayalllistBL.delegate = self
                    //                        self.addAnotherCard()
                    //                    }else {
                    //                       // self.objpayalllistBL.delegate = self
                    //                       // self.addCustomerCard()
                    //                    }
                    self.addCardInStipe_API(cardToken: self.Card_tokenId)
                }
                
            } else {
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                self.btnpay.isEnabled = true
                //print(error as Any)
                //failed
                // print("Failed")
                
                //print(error!.localizedDescription)
                let alert = UIAlertController(title: error!.localizedDescription, message: "How can I help you", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in
                    //print("User click Delete button")
                }))
                
                self.present(alert, animated: true, completion: {
                    // print("completion block")
                })
                
                
            }
        }
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
        
        selectcardname_txt.inputView = countryPickerView
        selectcardname_txt.inputAccessoryView = toolBar
        
        
    }
    @objc func donePicker() {
        if pickerData.count > 0 {
            self.selectcardname_txt.text = pickerData[selectedRow]
            txtCVCnumber.text = ""
            selectcardname_txt.resignFirstResponder()
        }else{
            
            selectcardname_txt.resignFirstResponder()
            
            let alert = UIAlertController(title: "", message: NSLocalizedString("Please select card name.", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "OK", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }
    }
    
    @objc func canclePicker() {
        selectcardname_txt.resignFirstResponder()
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
    func pay() {
        // Collect card details on the client
        cardNumber = self.txtCardNumber.text!
        let replaced = cardNumber.replacingOccurrences(of: "-", with: "")
        let cardExpirddate = self.txtMonthYear.text
        let expiryParameters = cardExpirddate?.components(separatedBy: "/")
        let cardCVCNo = self.txtCVCnumber.text
        let params = STPCardParams()
        params.number = replaced
        params.expMonth = UInt((expiryParameters?.first)!)!
        params.expYear = UInt((expiryParameters?.last)!)!
        params.cvc = cardCVCNo
        params.name = self.txtCardUsername.text
        params.currency = "gbp"
        let cardParam = STPPaymentMethodCardParams(cardSourceParams: params)
        // print(cardParam)
        let paymentMethodParams = STPPaymentMethodParams(card: cardParam, billingDetails: nil, metadata: nil)
        STPAPIClient.shared.createPaymentMethod(with: paymentMethodParams) { [weak self] paymentMethod, error in
            // Create PaymentMethod failed
            if let createError = error {
                print(createError.localizedDescription)
                // self?.displayAlert(title: "Payment failed", message: createError.localizedDescription)
            }else
            if let paymentMethodId = paymentMethod?.stripeId {
                // print("Created PaymentMethod")
                // print(paymentMethodId)
                //  self?.pay(withPaymentMethod: paymentMethodId)
            }
        }
    }
    
    func isCardDetailValid() -> Bool {
        cardNumber = self.txtCardNumber.text!
        let replaced = cardNumber.replacingOccurrences(of: "-", with: "")
        let cardExpirddate = self.txtMonthYear.text
        let expiryParameters = cardExpirddate?.components(separatedBy: "/")
        let cardCVCNo = self.txtCVCnumber.text
        let params = STPCardParams()
        params.number = replaced
        params.expMonth = UInt((expiryParameters?.first)!)!
        params.expYear = UInt((expiryParameters?.last)!)!
        params.cvc = cardCVCNo
        params.name = self.txtCardUsername.text
        params.currency = "gbp"
        //print(params)
        let state = STPCardValidator.validationState(forCard: params)
        if state == .valid {
            addcardandpay()
            
            return true
        } else {
            //print("card state = \(state)")
            let alert = UIAlertController(title: "Your card is invalid", message: "How can I help you", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in
            }))
            
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
            return false
        }
    }
 
    //MARK:-  ApI Call addCustomerCard///
    /**************************************************************************/
    func addCardInStipe_API(cardToken:String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        print(Userdetails)
        
        var email = Userdetails["useremail"] as? String ?? ""
        
        let parameters: Parameters = ["cardToken" : cardToken,"useremail" : email]
        let urlString = addPaymentCard
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.addCardInStipeAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.addCardInStipeAPICallError(error)
            }
        }
    }
    
    func addCardInStipeAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let status = dictPlayersInfo["status"] as! NSNumber
        print(dictPlayersInfo)
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            self.navigationController?.pop(animated: true)
            isBack = true
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
    }
    func addCardInStipeAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
    
    
}
