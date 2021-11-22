//
//  HomeViewController.swift
//  SwaplNFC
//
//  Created by Apple on 26/02/21.
//

import UIKit
import RSKImageCropper
import Alamofire
import SDWebImage
import Photos


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UIPopoverControllerDelegate, RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource{
    
    @IBOutlet weak var tblView: UITableView!
    var arrList :NSMutableArray = NSMutableArray()
    @IBOutlet weak var hightForViewsTable: NSLayoutConstraint!
    @IBOutlet weak var mainHeight: NSLayoutConstraint!
    @IBOutlet weak var lblPurchaseHistory: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var btnPurchaseHistory: UIButton!
    @IBOutlet weak var btnBagCount: UIButton!
    @IBOutlet weak var btnLevel: UIButton!
    @IBOutlet weak var btnPoints: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewUserImage: UIView!
    
    var dic1 = NSMutableDictionary()
    var dic2 = NSMutableDictionary()
    var dic3 = NSMutableDictionary()
    var userImage: UIImage!
    var popover   : UIPopoverController? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        let reachability = Reachability()!
        if !reachability.isReachable
        {
            let actionSheetController: UIAlertController = UIAlertController(title: "Internet is not responding. Please check the connection.", message: "", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "ok", style: .cancel) { action -> Void in
                //Do your task
                self.imageView.image = #imageLiteral(resourceName: "userDP")
            }
            actionSheetController.addAction(cancelAction)
            self.present(actionSheetController, animated: true, completion: nil)
        } else {
            let islogin = UserDefaults.standard.string(forKey: "Islogin")
        if islogin == "YES"{
            self.getUserInfo_API()
        }else{
            lblPurchaseHistory.text = "$0"
            lblPoints.text = "0"
            self.imageView.image = #imageLiteral(resourceName: "userDP")
        }
        }
        
        let localArrCount = localarrCount()
        btnBagCount.setTitle("\(localArrCount)", for: .normal)
        btnBagCount.setTitleColor(.black, for: .normal)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.0
        
        imageView.backgroundColor = UIColor.white
        imageView.layer.shadowColor = #colorLiteral(red: 0.5568627451, green: 0.007843137255, blue: 0.1215686275, alpha: 1)
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageView.layer.shadowRadius = 5
        

        dic1 = ["Imagename": "Experiences" ,"dis":"Touche's Backed Breads, Bourough"]
        dic2 = ["Imagename": "Extend My Palate" ,"dis":"Hedonism Wines"]
        dic3 = ["Imagename": "Food pairings" ,"dis":"Coffee with wine"]
        
        arrList.add(dic1)
        arrList.add(dic2)
        arrList.add(dic3)
        
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = false
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        mainHeight.constant = (809 + CGFloat(arrList.count * 140))
        hightForViewsTable.constant = CGFloat(arrList.count * 140)
        
    }
    
    //MARK:- All Button
    @IBAction func menuButtonClicked(_ sender: Any) {
        if let elDrawer = self.navigationController?.parent as? KYDrawerController {
            elDrawer.setDrawerState(.opened, animated: true)
        }else if let elDrawer = self.navigationController?.parent?.parent as? KYDrawerController {
            elDrawer.setDrawerState(.opened, animated: true)
        } else {
            let elDrawer = (self.navigationController!.parent?.parent?.parent! as!  KYDrawerController)
            elDrawer.setDrawerState(.opened, animated: true)
        }
    }
    @IBAction func BTN_PurchaseHistory(_ sender: Any) {

        
//        let yourURL = NSURL(string: "http://somewebsite.com/somefile.pdf")
//        savePdf(urlString: "http://www.africau.edu/images/default/sample.pdf", fileName: "pasdvan.pdf")

        let islogin = UserDefaults.standard.string(forKey: "Islogin")
        if islogin == "YES"{
            let NextPage = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
            self.navigationController?.pushViewController(NextPage, animated: false)
        }else{
        
        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Please login first", comment: ""), message: "", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel) { action -> Void in
            //Do your task
        }


        actionSheetController.addAction(okAction)
        self.present(actionSheetController, animated: true, completion: nil)
        }
        
    }
    
    func savePdf(urlString:String, fileName:String) {
        
            DispatchQueue.main.async {
                let url = URL(string: urlString)
                let pdfData = try? Data.init(contentsOf: url!)
                let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
                let pdfNameFromUrl = "YourAppName-\(fileName).pdf"
                let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
                do {
                    try? FileManager.default.removeItem(atPath: "path/to/file.txt")
                    try pdfData?.write(to: actualPath, options: .atomic)
                    print("pdf successfully saved!")
                } catch {
                    print("Pdf could not be saved")
                }
            }
        }
    
    @IBAction func BTN_Level(_ sender: Any) {
        
    }
    
    
    
    @IBAction func BTN_Points(_ sender: Any) {
    }
    @IBAction func BTN_ThreeDot(_ sender: Any) {
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
        // editProfile.dicDetails = dict! as NSDictionary
        self.navigationController?.pushViewController(editProfile, animated: false)
    }
    
    //MARK:-  ApI Call get card list///
    /**************************************************************************/
    func getUserInfo_API() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        let email = Userdetails["useremail"] as? String ?? ""
        let parameters: Parameters = ["useremail" : email]
        let urlString = getuserInfo
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.getUserInfoAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.getUserInfoAPICallError(error)
            }
        }
    }
    
    func getUserInfoAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let data = dictPlayersInfo["data"] as! NSDictionary
            let userDetails = data["userDetails"] as! NSDictionary
            lblPurchaseHistory.text = "$\(userDetails.GotValue(key: "history") as String)"
            lblPoints.text = userDetails.GotValue(key: "points") as String
            lblLevel.text = userDetails.GotValue(key: "stater") as String
            
            let userImaged_str = userDetails.GotValue(key: "image") as String
           var baseurl = userProfileimage + userImaged_str
            
            imageView.sd_setShowActivityIndicatorView(true)
            imageView.sd_setIndicatorStyle(.gray)
            imageView?.sd_setImage(with: NSURL(string : baseurl)! as URL) { (image, error, cache, urls) in
                if (error != nil) {
                    self.imageView.image = #imageLiteral(resourceName: "userDP")
                    self.imageView.sd_setShowActivityIndicatorView(false)
                } else {
                    self.imageView.image = image
                    self.userImage = image
                    self.imageView.sd_setShowActivityIndicatorView(false)
                }
            }
            
            
        }else{
            ShowCustomAlert.showCenter(withMessage: message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
 
    }
    func getUserInfoAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "\(error)")
    }
    
    
}

extension HomeViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        let dict = arrList.object(at: indexPath.row) as? NSDictionary
        cell.imageDis?.image =  UIImage(named: "\(dict!.GotValue(key: "Imagename") as String)")
        
        cell.imageDis.layer.cornerRadius = 25.0
        cell.imageDis.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.imageDis.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.imageDis.layer.shadowOpacity = 1
        cell.imageDis.layer.shadowRadius = 2.0
        
        //cell.imageDis.sizeToFit()
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = arrList.object(at: indexPath.row) as? NSDictionary
        
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ExperiencelistViewController") as! ExperiencelistViewController
        editProfile.selectedType = dict!["Imagename"] as! String
        APPDELEGATE.strSelectedType = dict!["Imagename"] as! String
        self.navigationController?.pushViewController(editProfile, animated: false)
        
//        if  indexPath.row == 0{
//
//        let dict = arrList.object(at: indexPath.row) as? NSDictionary
//
//        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ExperiencelistViewController") as! ExperiencelistViewController
//        editProfile.selectedType = dict!["Imagename"] as! String
//        self.navigationController?.pushViewController(editProfile, animated: false)
//        }else{
//            let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ThanksuViewController") as! ThanksuViewController
//            self.navigationController?.pushViewController(editProfile, animated: false)
//        }
        
    }
    
    //MARK:- Open Device camera and gallery
    @IBAction func ActionForOpenCameraAndgallery(_ sender: UIButton) {
        
        let islogin = UserDefaults.standard.string(forKey: "Islogin")
    if islogin == "YES"{
        let alert:UIAlertController=UIAlertController(title: NSLocalizedString("Choose photos", comment: ""), message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallery  = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.galleryOpen()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancelAction)
        // Present the controller
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            popover = UIPopoverController(contentViewController: alert)
            popover!.present(from: imageView.frame, in: self.view, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
        }
        
    }else{
    
        
                    let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Please login ", comment: ""), message: "", preferredStyle: .alert)
                    let okAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { action -> Void in
                        //Do your task
                        
                        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        // editProfile.dicDetails = dict! as NSDictionary
                        editProfile.selectType = "Home"
                        self.navigationController?.pushViewController(editProfile, animated: false)
                        
                    }
        let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            //Do your task
        }
        
                    actionSheetController.addAction(okAction)
                    actionSheetController.addAction(cancelAction)
                    self.present(actionSheetController, animated: true, completion: nil)
        
    }
        
        
     
        
        
    }
    func checkCameraAccess() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
            break
        case .authorized:
            print("Authorized, proceed")
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                    
                }
            }
        @unknown default:
            fatalError()
        }
    }
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "",
                                                message: "Please enable camera access in settings",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
    }
    func openCamera() {
        checkCameraAccess()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
        func galleryOpen()
    {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = false
        imagePickerVC.sourceType = .savedPhotosAlbum
        
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if (!(picker.sourceType == UIImagePickerController.SourceType.photoLibrary)) {
            
            
            picker.dismiss(animated: false, completion: nil)
            
            self.afterImagePickerSelection(true, pickedProfile: (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!)
            
        } else {
            
            let assetPath = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
            if (assetPath.absoluteString?.hasSuffix("GIF"))! {
                picker.dismiss(animated: true, completion: nil)
                
                Toast.show(message: "GIF image not supported.", controller: self)
                
            } else {
                
                picker.dismiss(animated: false, completion: nil)
                
                
                self.afterImagePickerSelection(true, pickedProfile: (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!)
            }
        }
    }
    
    //MARK:- IMAGE CROPPER
    func afterImagePickerSelection(_ flag: Bool, pickedProfile: UIImage) {
        
        let imageCropVC = RSKImageCropViewController(image: pickedProfile, cropMode: .circle)
        imageCropVC.delegate = self
        imageCropVC.dataSource = self
        imageCropVC.avoidEmptySpaceAroundImage = true
        self.present(imageCropVC, animated: false, completion: nil)
    }
    func imageCropViewControllerCustomMaskRect(_ controller: RSKImageCropViewController) -> CGRect {
        
        
        print("---\(self.imageView.frame.size.height)")
        
        //  return CGRect(x: 0, y: 0 , width: self.imageView.frame.size.width, height: self.imageView.frame.size.height)
        
        return CGRect(x: 0, y: 0 , width: 300, height: 300)
    }
    func imageCropViewControllerCustomMaskPath(_ controller: RSKImageCropViewController) -> UIBezierPath {
        
        return UIBezierPath(rect: controller.maskRect)
    }
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
        
        // ...
    }
    func imageCropViewControllerCustomMovementRect(_ controller: RSKImageCropViewController) -> CGRect {
        let rect = controller.maskRect
        
        return rect
    }
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        self.dismiss(animated: true, completion: nil)
        imageView.image = croppedImage
        self.userImage = croppedImage
        
                let reachability = Reachability()!
                if !reachability.isReachable
                {
        
                    let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("No internet.", comment: ""), message: "", preferredStyle: .alert)
                    let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { action -> Void in
                        //Do your task
                    }
                    actionSheetController.addAction(cancelAction)
                    self.present(actionSheetController, animated: true, completion: nil)
        
                } else {
                    
                    let islogin = UserDefaults.standard.string(forKey: "Islogin")
                if islogin == "YES"{
                    SaveProfileAPIOnly()
                }
        
                }
        
    }
    
    //MARK:- SaveProfileAPIOnly
    
    func SaveProfileAPIOnly()
    {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let headers: HTTPHeaders = ["Authorization":"Bearer",
                                    "Content-type": "multipart/form-data"]
        var URL = try! URLRequest(url: uploaduserProfileimage, method: .post, headers: headers)
        URL.timeoutInterval = 500
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userdata") as? NSDictionary ?? [:]
        let email = Userdetails["useremail"] as? String ?? ""
        let parameters: Parameters = ["useremail" : email]
        
        var profile_type = ""
 
        
        var userImageCreate = UIImage()
        if self.userImage != nil{
            //            userImageCreate = resizeImage(image: userImage, newWidth: 512.0)!
            userImageCreate = userImage
        }
        let imageData = userImageCreate.jpegData(compressionQuality: 0.2)
        AF.upload(multipartFormData: { (multipartFormData) in
     
            if self.userImage == nil{
            }else{
                multipartFormData.append(imageData!, withName: "image",fileName: "imageUrl" , mimeType: "image/jpg")
            }
            multipartFormData.append(("\(email)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "useremail")
            
        }, with: URL).responseJSON { (response) in
            switch response.result {
            case .success(let value) :
                self.SaveProfileAPICallFinished(value as! NSDictionary)
                break
            case .failure(let error) :
                print(error)
                self.SaveProfileAPICallError(error)
                break
            }
        }
    }
    
    func SaveProfileAPICallFinished(_ dictPlayersInfo: NSDictionary) {
        
        let data = dictPlayersInfo["data"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            ShowCustomAlert.show(withMessage:message)
            
        } else {
            
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }
    func SaveProfileAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage:"Something went wrong please try again ")
    }
    
}


