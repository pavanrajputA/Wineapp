//
//  SignupViewController.swift
//  Wine
//
//  Created by Apple on 22/07/21.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRepidPassword: UITextField!
    var selectType = ""
    var maxLen:Int = 14;

    var isBack = true
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtRepidPassword.delegate = self
        txtName.autocorrectionType = .no
        txtEmail.autocorrectionType = .no
        txtPassword.autocorrectionType = .no
        txtRepidPassword.autocorrectionType = .no
        // Do any additional setup after loading the view.
        addDoneButtonOnKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if APPDELEGATE.isBack == true {
            self.navigationController?.popToRoot(animated: false)
            APPDELEGATE.isBack = false
        }else{
            APPDELEGATE.isBack = false
        }
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    
    @IBAction func btnLoginop(_ sender: Any) {
        
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    

    @IBAction func btnSignup(_ sender: Any) {
        


        txtEmail.resignFirstResponder();
        txtPassword.resignFirstResponder();
        txtRepidPassword.resignFirstResponder();
        txtName.resignFirstResponder();

        
        if txtEmail.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        } else if !self.isValidEmail(txtEmail.text!)
        {
            
            let alert = UIAlertController(title: "", message:  "Please enter valid email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
            
        } else if txtName.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter Username", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "Ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }
        else if txtPassword.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }else if txtRepidPassword.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter confirm password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }else if !(self.txtPassword.text == self.txtRepidPassword.text!)        {
            
            let alert = UIAlertController(title: "", message:  "Password dosen't matched", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
            
        }else if (txtPassword.text!.count < 8)
        {
            let alert = UIAlertController(title: "", message:  "Password should be 8 characters", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }else if (txtRepidPassword.text!.count < 8)
        {
            let alert = UIAlertController(title: "", message:  "Password should be 8 characters", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }
        else {
            txtEmail.text = txtEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let string:String = txtEmail.text!
            if string.range(of:" ") != nil {
                let alert = UIAlertController(title: "", message: "Please remove space from email", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction (title: "ok", style: UIAlertAction.Style.default, handler:nil))
                self.present(alert, animated: true, completion:nil)
            } else {
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
                    SignupAPIOnly()
                    }
            }
        }
        
        
  //      SignupAPIOnly()
//        self.navigationController?.pop(animated: true)
//        isBack = true
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
        
        txtEmail.inputAccessoryView = doneToolbar
        txtPassword.inputAccessoryView = doneToolbar
        txtName.inputAccessoryView = doneToolbar
        txtRepidPassword.inputAccessoryView = doneToolbar
    }
    
    
        @objc func doneButtonAction()
        {
            
            txtEmail.resignFirstResponder();
            txtPassword.resignFirstResponder();
            txtName.resignFirstResponder();
            txtRepidPassword.resignFirstResponder();
     
        }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtName
        {
         
            if  textField == txtName{
                let currentText = textField.text! + string
                return currentText.count <= 30

            }
         
         
     }else if textField == txtPassword{
            
            if(textField == txtPassword){
                  let currentText = textField.text! + string
                  return currentText.count <= maxLen
               }

               return true;
             
        }else if textField == txtRepidPassword{
            
            if(textField == txtRepidPassword){
                  let currentText = textField.text! + string
                  return currentText.count <= maxLen
               }

               return true;
             
        }
           return true
        
    }
    
    
    //MARK:-  ApI Call///
    func SignupAPIOnly() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let parameters: Parameters = [ "useremail" : txtEmail.text!, "password" : txtPassword.text!, "username" : txtName.text!]
        
        print("URL : \(SignupApi)")
        print("parameters : \(parameters)")
        
        let url = URL.init(string: SignupApi)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print("response : \(response)")
            
                        switch response.result
                       {
                       case .success(let json):
                           let jsonData = json as! Any
                           print(json)
                        self.SignupAPICallFinished(json as! NSDictionary)
                        
                       case .failure(let error):
                           self.SignupAPICallError(error)
                       }
            
        }
    }
        
    func SignupAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        
        if (status == 1) {
            
            let userdata = data as! NSDictionary
            let userDefaults = UserDefaults.standard
            userDefaults.set(userdata, forKey: "userdata")
            let Userdetails = userDefaults.object(forKey: "userdata") as! NSDictionary
            
            let shippingDetails = userdata["shippingDetails"] as! NSDictionary
            userDefaults.set(shippingDetails, forKey: "shippingDetails")
            
            if selectType == "Bag"{
                //self.navigationController?.popToRoot(animated: false)
                UserDefaults.standard.set("YES", forKey: "Islogin")
                    
                    let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ShippingDetailsViewController") as! ShippingDetailsViewController
                editProfile.wherefrom = "Signup"
                    self.navigationController?.pushViewController(editProfile, animated: false)
                    
            }else if selectType == "Home"{
                //self.navigationController?.popToRoot(animated: false)
                UserDefaults.standard.set("YES", forKey: "Islogin")
                self.navigationController?.popToRoot(animated: false)
            }else{
                let story:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let LoginView:KYDrawerController = (story.instantiateViewController(withIdentifier: "KYDrawerController") as? KYDrawerController)!
                UserDefaults.standard.set("YES", forKey: "Islogin")
                self.navigationController?.pushViewController(LoginView, animated: false)
            }
            
            
        }else{
            ShowCustomAlert.show(withMessage:message)
            
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
    }
    
    func SignupAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "internet isssue")
    }
    // MARK: -  MARK Validition In Email id
    func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
