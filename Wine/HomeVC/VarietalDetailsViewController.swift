//
//  VarietalDetailsViewController.swift
//  Wine
//
//  Created by Apple on 26/07/21.
//

import UIKit
import Alamofire

class VarietalDetailsViewController: UIViewController {
    @IBOutlet weak var lblDescripation: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var lblcolor: UILabel!
    @IBOutlet weak var lblcolor_intensity: UILabel!
    
    @IBOutlet weak var lblaroma_intensity: UILabel!
    @IBOutlet weak var lblsweetness: UILabel!
    
    @IBOutlet weak var lblacidity: UILabel!
    @IBOutlet weak var lblalcohol: UILabel!
    
    @IBOutlet weak var lblbody: UILabel!
    @IBOutlet weak var lblflavor_intensity: UILabel!
    
    @IBOutlet weak var lbltannin: UILabel!
    @IBOutlet weak var lblfinish: UILabel!
    
    @IBOutlet weak var btnBagCount: UIButton!

    
    var dataDetails = NSDictionary()
    var nameStr = ""
    var disStr = ""
    var imageStr = ""
    var isBack = true
    var selectedType = ""
    var wineID = NSNumber()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblName.text = selectedType
        
        print(dataDetails)
        
        
        let id = dataDetails["id"] as! NSNumber
        lblName.text = dataDetails["name"] as! String
        
       
        
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
            self.varietalDetails_API(type: "\(id)", name: lblName.text!)
            }
    }
    override func viewDidAppear(_ animated: Bool) {
        if APPDELEGATE.isBack == true {
            self.navigationController?.popToRoot(animated: false)
            APPDELEGATE.isBack = false
        }else{
            APPDELEGATE.isBack = false
        }
        
        let localArrCount = localarrCount()
        btnBagCount.setTitle("\(localArrCount)", for: .normal)
        btnBagCount.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func btnDetails(_ sender: Any) {
        
        let nextPage = self.storyboard?.instantiateViewController(withIdentifier: "CharacteristicsViewController") as! CharacteristicsViewController
            nextPage.wineId = wineID
        nextPage.Str_name = lblName.text!
        
            self.navigationController?.pushViewController(nextPage, animated: false)
        
    }
    @IBAction func btnNextpage(_ sender: Any) {
        
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ForeWineViewController") as! ForeWineViewController
        
        editProfile.winid = wineID
        editProfile.strTital = lblName.text!
        self.navigationController?.pushViewController(editProfile, animated: false)
        
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    @IBAction func btnBag(_ sender: Any) {
        
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
        // editProfile.dicDetails = dict! as NSDictionary

        self.navigationController?.pushViewController(editProfile, animated: false)
    }
    
    /**************************************************************************/
    //MARK:-  ApI Call ///
    /**************************************************************************/
    func varietalDetails_API(type:String, name: String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let parameters: Parameters = ["id" : type, "name" : name]
        let urlString = varietalDetails
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.varietalDetailsAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.varietalDetailsAPICallError(error)
            }
        }
    }
    func varietalDetailsAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        print(dictPlayersInfo)
        
        let message = dictPlayersInfo["Message"] as! String
        if (status == 1) {
            
            
            let userdata = data!["details"] as! NSDictionary
            lblName.text = data!["screenName"] as! String
                        lblaroma_intensity.text = userdata["aroma_intensity"] as! String
                        lblcolor.text = userdata["color"] as! String
                        lblcolor_intensity.text = userdata["color_intensity"] as! String
                        lblsweetness.text = userdata["sweetness"] as! String
                        lblacidity.text = userdata["acidity"] as! String
                        lblalcohol.text = userdata["alcohol"] as! String
                        lbltannin.text = userdata["tannin"] as! String
                        lblfinish.text = userdata["finish_length"] as! String
                        lblbody.text = userdata["body"] as! String
                        lblDescripation.text = userdata["description"] as! String
                        lblflavor_intensity.text = userdata["aroma_intensity"] as! String
            wineID = userdata["id"] as! NSNumber
            
            let imageURL =  imagePath + "\(userdata.GotValue(key: "image") as String)"
            
            image.sd_setShowActivityIndicatorView(true)
            image.sd_setIndicatorStyle(.gray)
            image?.sd_setImage(with: NSURL(string : imageURL)! as URL) { (image, error, cache, urls) in
                    if (error != nil) {
                        self.image.image = #imageLiteral(resourceName: "4")
                        self.image.sd_setShowActivityIndicatorView(false)
                    } else {
                        self.image.image = image
                        self.image.sd_setShowActivityIndicatorView(false)
                    }
                }
            
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
    }
    func varietalDetailsAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
}
