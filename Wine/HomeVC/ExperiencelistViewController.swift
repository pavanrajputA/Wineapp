//
//  ExperiencelistViewController.swift
//  Wine
//
//  Created by Apple on 20/07/21.
//




import UIKit
import Alamofire

class ExperiencelistViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private var collectionView : UICollectionView!
    var arrSocial : NSMutableArray = NSMutableArray()
    @IBOutlet var lblTitleheader: UILabel!
    @IBOutlet weak var mainView : UIView!
    var isBack = true
    var selectedType = ""
    @IBOutlet weak var btnBagCount: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        lblTitleheader.text = selectedType
            if selectedType == "Experiences"{
               
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
                    self.listExperience_API(type: "1")
                    }
                
            } else if selectedType == "Extend My Palate"{
                
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
                     self.listExperience_API(type: "7")
                     }
            }
            else if selectedType == "Food pairings"{
                
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
                     self.listExperience_API(type: "8")
                     }
            }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: mainView.frame.size.width/3.2, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.register(UINib(nibName: "ExperienceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExperienceCollectionViewCell")
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .clear
        collectionView?.isScrollEnabled = true
        mainView.addSubview(collectionView!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView?.frame = mainView.bounds
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
    
    //MARK:- Button
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    @IBAction func btnBag(_ sender: Any) {
        
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
        // editProfile.dicDetails = dict! as NSDictionary
        
        self.navigationController?.pushViewController(editProfile, animated: false)
    }
    
    //MARK:- collectionView method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSocial.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExperienceCollectionViewCell", for: indexPath) as! ExperienceCollectionViewCell
        let dict = arrSocial.object(at: indexPath.row) as! NSDictionary
        let name = dict["name"] as! String
        cell.lblName.text = name
        cell.image.isHidden = true
    
    let imageURL =  imagePath + "\(dict["image"] as! String)"
        var imageUrl: URL? {
            if let url = URL(withCheck: imageURL) {
                return url
            }
            if let url = URL(withCheck: imageURL) {
                return url
            }
            return nil
        }
        
        
        cell.imageScond.sd_setShowActivityIndicatorView(true)
        cell.imageScond.sd_setIndicatorStyle(.gray)
        cell.imageScond?.sd_setImage(with: imageUrl) { (image, error, cache, urls) in
            if (error != nil) {
                cell.imageScond.image = #imageLiteral(resourceName: "4")
                cell.imageScond.sd_setShowActivityIndicatorView(false)
            } else {
                cell.imageScond.image = image
                cell.imageScond.sd_setShowActivityIndicatorView(false)
            }
            
        }
        cell.imageScond.layer.masksToBounds = false
        cell.imageScond.layer.borderWidth = 0.0
        
        cell.imageScond.layer.shadowColor = #colorLiteral(red: 0.5568627451, green: 0.007843137255, blue: 0.1215686275, alpha: 1)
        cell.imageScond.layer.shadowOpacity = 1
        cell.imageScond.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.imageScond.layer.shadowRadius = 5
        cell.shadowDecorate()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainView.frame.size.width/2.2, height: 170);
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dict = arrSocial.object(at: indexPath.row) as? NSDictionary
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "EventlistViewController") as! EventlistViewController
        editProfile.selectedType = dict!["name"] as! String
        editProfile.fullDicData = dict as! NSDictionary
        self.navigationController?.pushViewController(editProfile, animated: false)
        
    }
    
    /**************************************************************************/
    //MARK:-  ApI Call socialLogin///
    /**************************************************************************/
    func listExperience_API(type:String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let parameters: Parameters = [ "id" : type]
        let urlString = listExperience
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.ExperienceAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.ExperienceAPICallError(error)
            }
        }
    }
    func ExperienceAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["Message"] as! String
        if (status == 1) {
            let userdata = data!["list"] as! NSArray
            for i in userdata{
                arrSocial.add(i as! NSDictionary)
            }
            collectionView.reloadData()
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
    }
    func ExperienceAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
}
extension UICollectionViewCell {
    /// Call this method from `prepareForReuse`, because the cell needs to be already rendered (and have a size) in order for this to work
    func shadowDecorate(radius: CGFloat = 8,
                        shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3),
                        shadowOffset: CGSize = CGSize(width: 0, height: 1.0),
                        shadowRadius: CGFloat = 3,
                        shadowOpacity: Float = 1) {
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
