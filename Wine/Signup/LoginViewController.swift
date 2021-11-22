//
//  LoginViewController.swift
//  Wine
//
//  Created by Apple on 22/07/21.
//

import UIKit

import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import Alamofire
import Firebase


class LoginViewController: UIViewController ,UITextFieldDelegate, ASAuthorizationControllerDelegate {
    var userDefaults = UserDefaults.standard
    
    @IBOutlet weak var view_googleLoginBtn : UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var Google_BTN: UIButton!
    
    @IBOutlet weak var view_AppleLogin : UIView!
    var isBack = true
    
    var selectType = ""
    let signInConfig = GIDConfiguration.init(clientID: "449317403559-qnv83bjqde28ub7i8iltl6n6na181iel.apps.googleusercontent.com")

    override func viewDidLoad() {
        super.viewDidLoad()

       // self.setupSOAppleSignIn()
        
        // Do any additional setup after loading the view.
        
       
        txtEmail.delegate = self
        txtPassword.delegate = self

        
        txtEmail.autocorrectionType = .no
        txtPassword.autocorrectionType = .no
    }
    override func viewDidAppear(_ animated: Bool) {
        
//        txtEmail.autocorrectionType = .no
//        txtPassword.delegate = self
//        self.txtEmail.attributedPlaceholder = NSAttributedString(string: txtEmail.placeholder!,
//                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
//        self.txtPassword.attributedPlaceholder = NSAttributedString(string: txtPassword.placeholder!,
//                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        addDoneButtonOnKeyboard()
        
        if APPDELEGATE.isBack == true {
            self.navigationController?.popToRoot(animated: false)
            APPDELEGATE.isBack = false
        }else{
            APPDELEGATE.isBack = false
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
if textField == txtPassword{
            
            if(textField == txtPassword){
                  let currentText = textField.text! + string
                  return currentText.count <= 14
               }

               return true;
             
        }
           return true
        
    }
 
    func actionHandleAppleSignin() {

           let appleIDProvider = ASAuthorizationAppleIDProvider()

           let request = appleIDProvider.createRequest()

           request.requestedScopes = [.fullName, .email]

           let authorizationController = ASAuthorizationController(authorizationRequests: [request])

           authorizationController.delegate = self

           authorizationController.presentationContextProvider = self

           authorizationController.performRequests()
        
    

       }
    
    

    @IBAction func btnBack(_ sender: Any) {
    
        //self.navigationController?.pop(animated: true)
        
        if selectType == "Bag"{
            self.navigationController?.popToRoot(animated: false)
        }else if selectType == "Home"{
            //self.navigationController?.popToRoot(animated: false)
            self.navigationController?.popToRoot(animated: false)
        }else{
            let story:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let LoginView:KYDrawerController = (story.instantiateViewController(withIdentifier: "KYDrawerController") as? KYDrawerController)!
            self.navigationController?.pushViewController(LoginView, animated: false)
        }
        

        isBack = true

    }
    
    @IBAction func btnApplelogin(_ sender: Any) {
        actionHandleAppleSignin()
    }
    @IBAction func btnGooglelogin(_ sender: Any) {
                GIDSignIn.sharedInstance.signOut()
                GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
                   guard error == nil else { return }
                    let userProfileName = user?.profile!.name
                    let userProfileEmail = user?.profile!.email
        
                    
                    print("\(userProfileName)")
                    
                    self.googleAuth_API(email: userProfileEmail!, name: userProfileName!)
                   // If sign in succeeded, display the app's main content View.
                    
                 }
    }
    
    
    @IBAction func btnSignupTop(_ sender: Any) {
        
        
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        editProfile.selectType = selectType
        
        self.navigationController?.pushViewController(editProfile, animated: false)
    }

    @IBAction func btnLogin(_ sender: Any) {
        
    
        txtEmail.resignFirstResponder();
        txtPassword.resignFirstResponder();
      
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
            
        } else if txtPassword.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "Ok", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion:nil)
        }
        else if txtPassword.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "", message: "Enter password", preferredStyle: UIAlertController.Style.alert)
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
                    LoginAPIOnly()
                    }
            }
        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil)
        {
            print("look like error : \(String(describing: error))")
        } else {
            
//            var userProfileName = user.profile.name
//            userProfileName = userProfileName?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//            print(userProfileName ?? "")
//            UserDefaults.standard.set(userProfileName, forKey: "user_name_GA")
//            //    let email = user.profile.email
//
//            let email = user.profile.email ?? ""
//            let name = user.profile.name ?? ""
//
//            self.googleAuth_InvokeAPI(email: email, name: name)
//
            
            //    GmailuserId = user.userID! as NSString
            //    let profilePicURL:URL = user.profile.imageURL(withDimension: 175)
            //    let strimage:String? = ((String(describing: profilePicURL)) as String as NSString) as String
            //    GmailprofilePicURL  = strimage as! NSString
            //    Gmailemailency = (try! email?.aesEncrypt())! as NSString
            //    Gmailfullname = (try! userProfileName?.aesEncrypt())! as NSString
            //    print(Gmailfullname)
            //    print(Gmailemailency)
            //    print(GmailprofilePicURL)
            //    print(GmailuserId)
            //    login_type = "1"
            //    objLoginBL.delegate = self
            //    socialloginAPICallOnly()
        }
    }
    
    // Start Google OAuth2 Authentication
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        
        // Showing OAuth2 authentication window
        if let aController = viewController {
            present(aController, animated: true) {() -> Void in }
        }
    }
    
    // After Google OAuth2 authentication
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        // Close OAuth2 authentication window
        dismiss(animated: true) {() -> Void in }
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
    }
    
    
        @objc func doneButtonAction()
        {
            
            txtEmail.resignFirstResponder();
            txtPassword.resignFirstResponder();
     
        }
    
    



     // ASAuthorizationControllerDelegate function for authorization failed

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

        print(error.localizedDescription)

    }

       // ASAuthorizationControllerDelegate function for successful authorization

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            // Create an account as per your requirement

            let appleId = appleIDCredential.user

            let appleUserFirstName = appleIDCredential.fullName?.givenName ?? ""

            let appleUserLastName = appleIDCredential.fullName?.familyName

            let appleUserEmail = appleIDCredential.email ?? ""

            //Write your code
            
            print("\(appleId) email --\(appleUserEmail)")
            self.appleAuth_API(email: appleUserEmail as! String, name: appleUserFirstName as! String, id: appleId)

        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {

            let appleUsername = passwordCredential.user

            let applePassword = passwordCredential.password

            //Write your code

        }

    }
    
    
    /**************************************************************************/
    //MARK:-  ApI Call///
    /**************************************************************************/
    
    func LoginAPIOnly()
    { // local video file path..
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        txtEmail.resignFirstResponder();
        txtPassword.resignFirstResponder();

        let parameters: Parameters = [ "useremail" : txtEmail.text!, "password" : txtPassword.text!]
        let urlString = loginApi
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                        switch response.result
                       {
                       case .success(let json):
                           let jsonData = json as! Any
                           print(jsonData)
               self.LoginAPICallFinished(json as! NSDictionary)
                       case .failure(let error):
                           self.LoginAPICallError(error)
                       }
        }
    }
    
    func LoginAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        print(data)
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let userdata = data as! NSDictionary
            let userDefaults = UserDefaults.standard
    
            userDefaults.set(userdata, forKey: "userdata")
        
            let shippingDetails = userdata["shippingDetails"] as! NSDictionary
    
            userDefaults.set(shippingDetails, forKey: "shippingDetails")
            
            
            if selectType == "Bag"{
                //self.navigationController?.popToRoot(animated: false)
                UserDefaults.standard.set("YES", forKey: "Islogin")
                    
                    let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ShippingDetailsViewController") as! ShippingDetailsViewController
                editProfile.wherefrom = "Login"
                
                    self.navigationController?.pushViewController(editProfile, animated: false)
                    
            }else if selectType == "Home"{
                //self.navigationController?.popToRoot(animated: false)
                UserDefaults.standard.set("YES", forKey: "Islogin")
                self.navigationController?.popToRoot(animated: false)
            }else{
                UserDefaults.standard.set("YES", forKey: "Islogin")
                let story:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let LoginView:KYDrawerController = (story.instantiateViewController(withIdentifier: "KYDrawerController") as? KYDrawerController)!
                self.navigationController?.pushViewController(LoginView, animated: false)
            }
            
        
            
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
       
    }
    func LoginAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
    
    /**************************************************************************/
    //MARK:-  ApI Call socialLogin///
    /**************************************************************************/
    func appleAuth_API(email:String, name:String, id: String) {
 // local video file path..
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        txtEmail.resignFirstResponder();
        txtPassword.resignFirstResponder();

        let parameters: Parameters = [ "useremail" : email, "username" : name, "appleid" : id ,"loginfrom" : "apple"]
        let urlString = loginApi
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                        switch response.result
                       {
                       case .success(let json):
                           let jsonData = json as! Any
                           print(jsonData)
               self.appleAPICallFinished(json as! NSDictionary)
                       case .failure(let error):
                           self.appleAPICallError(error)
                       }
        }
    }
    
    func appleAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
    
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let userdata = data as! NSDictionary
            let userDefaults = UserDefaults.standard
            userDefaults.set(userdata, forKey: "userdata")

            let shippingDetails = userdata["shippingDetails"] as! NSDictionary
        
            userDefaults.set(shippingDetails, forKey: "shippingDetails")

            
            if selectType == "Bag"{
                //self.navigationController?.popToRoot(animated: false)
                UserDefaults.standard.set("YES", forKey: "Islogin")
                    
                    let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ShippingDetailsViewController") as! ShippingDetailsViewController
                editProfile.wherefrom = "Login"
                
                    self.navigationController?.pushViewController(editProfile, animated: false)
                    
            }else if selectType == "Home"{
                //self.navigationController?.popToRoot(animated: false)
                UserDefaults.standard.set("YES", forKey: "Islogin")
                self.navigationController?.popToRoot(animated: false)
            }else{
                UserDefaults.standard.set("YES", forKey: "Islogin")
                let story:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let LoginView:KYDrawerController = (story.instantiateViewController(withIdentifier: "KYDrawerController") as? KYDrawerController)!
                self.navigationController?.pushViewController(LoginView, animated: false)
            }
            
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
       
    }
    func appleAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
    
    /**************************************************************************/
    //MARK:-  ApI Call socialLogin///
    /**************************************************************************/
    func googleAuth_API(email:String, name:String) {
 // local video file path..
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        txtEmail.resignFirstResponder();
        txtPassword.resignFirstResponder();

        let parameters: Parameters = [ "useremail" : email, "username" : name , "loginfrom" : "google"]
        let urlString = loginApi
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                        switch response.result
                       {
                       case .success(let json):
                           let jsonData = json as! Any
                           print(jsonData)
               self.googleAPICallFinished(json as! NSDictionary)
                       case .failure(let error):
                           self.googleAPICallError(error)
                       }
        }
    }
    
    func googleAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        print(data)
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let userdata = data as! NSDictionary
            let userDefaults = UserDefaults.standard
            userDefaults.set(userdata, forKey: "userdata")

            let shippingDetails = userdata["shippingDetails"] as! NSDictionary
            userDefaults.set(shippingDetails, forKey: "shippingDetails")

            
            
            if selectType == "Bag"{
                //self.navigationController?.popToRoot(animated: false)
                UserDefaults.standard.set("YES", forKey: "Islogin")
                    
                    let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ShippingDetailsViewController") as! ShippingDetailsViewController
                editProfile.wherefrom = "Login"
                
                    self.navigationController?.pushViewController(editProfile, animated: false)
                    
            }else if selectType == "Home"{
                //self.navigationController?.popToRoot(animated: false)
                UserDefaults.standard.set("YES", forKey: "Islogin")
                self.navigationController?.popToRoot(animated: false)
            }else{
                UserDefaults.standard.set("YES", forKey: "Islogin")
                let story:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let LoginView:KYDrawerController = (story.instantiateViewController(withIdentifier: "KYDrawerController") as? KYDrawerController)!
                self.navigationController?.pushViewController(LoginView, animated: false)
            }
            
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
       
    }
    func googleAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
    
    // MARK: -  MARK Validition In Email id
    func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    
    
    
    
    
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {

    //For present window

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return self.view.window!

    }

}
