//
//  ForeWineViewController.swift
//  Wine
//
//  Created by Apple on 26/07/21.
//

import UIKit
import Alamofire
class ForeWineViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private var collectionView : UICollectionView!
    var arrSocial : NSMutableArray = NSMutableArray()
    @IBOutlet weak var mainView : UIView!
    @IBOutlet var lblTitleheader: UILabel!
    var dic1 = NSMutableDictionary()
    var dic2 = NSMutableDictionary()
    var dic3 = NSMutableDictionary()
    var dic4 = NSMutableDictionary()
    var isBack = true
    
    var winid = NSNumber()
    var strTital = ""
    
    @IBOutlet weak var btnBagCount: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
           self.winTypeList_API(type: "\(strTital)")
            }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: mainView.frame.size.width/3.2, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.register(UINib(nibName: "ForWineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ForWineCollectionViewCell")
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .clear
        collectionView?.isScrollEnabled = true
        mainView.addSubview(collectionView!)
        
        
        lblTitleheader.text = strTital
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForWineCollectionViewCell", for: indexPath) as! ForWineCollectionViewCell
        let dict = arrSocial.object(at: indexPath.row) as! NSDictionary
       
        cell.lblName.text = "\(dict["name"] as! String)"
        
        
        //
      cell.lblPrice.text = "$\(dict["prize"] as! Double)"

     cell.lblReview.text = "Reviews \(dict["reviews"] as! NSNumber)"
        cell.ratingView.rating = Double(dict["rating_count"] as! NSNumber)
        cell.ratingView.isUserInteractionEnabled = false
        let imageURL =  imagePath + "\(dict.GotValue(key: "image") as String)"
        var imageUrl: URL? {
            if let url = URL(withCheck: imageURL) {
                return url
            }
            if let url = URL(withCheck: imageURL) {
                return url
            }
            return nil
        }
        
        cell.image.sd_setShowActivityIndicatorView(true)
            cell.image.sd_setIndicatorStyle(.gray)
        cell.image?.sd_setImage(with: imageUrl) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image.image = #imageLiteral(resourceName: "4")
                    cell.image.sd_setShowActivityIndicatorView(false)
                } else {
                    cell.image.image = image
                    cell.image.sd_setShowActivityIndicatorView(false)
                }
            }
       // cell.shadowDecorate()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainView.frame.size.width/2.2, height: 190);
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        let dict = arrSocial.object(at: indexPath.row) as? NSDictionary
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "PerchaseViewController") as! PerchaseViewController
        editProfile.dicNewdata = dict! as NSDictionary
        self.navigationController?.pushViewController(editProfile, animated: false)

        
    }
    /**************************************************************************/
    //MARK:-  ApI Call ///
    /**************************************************************************/
    func winTypeList_API(type:String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let parameters: Parameters = ["varietals" : type]
        let urlString = winTypelist
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.winTypeAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.winTypeAPICallError(error)
            }
        }
    }
    func winTypeAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let status = dictPlayersInfo["status"] as! NSNumber
        print(dictPlayersInfo)
        
        let message = dictPlayersInfo["Message"] as! String
        if (status == 1) {
           
            let userdata = dictPlayersInfo["data"] as! NSArray
            for i in userdata{
                arrSocial.add(i as! NSDictionary)
            }
            collectionView.reloadData()
            
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
    }
    func winTypeAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
    
}
