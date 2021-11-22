//
//  PocornSubcat2ViewController.swift
//  Wine
//
//  Created by Pavan on 08/10/21.
//

import UIKit
import Alamofire

class PocornSubcat2ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    private var collectionView : UICollectionView!
    @IBOutlet weak var mainView : UIView!
    @IBOutlet var lblTitleheader: UILabel!
    @IBOutlet weak var btnBagCount: UIButton!

    var arrList :NSMutableArray = NSMutableArray()
    var isBack = true
    var typeOFsubcatories = ""
    var dataForSubcategories = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //lblTitleheader.text = typeOFsubcatories
        let id = dataForSubcategories["id"] as! NSNumber
        lblTitleheader.text = dataForSubcategories["name"] as! String
        
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
           self.listSubsub2Categories_API(type: "\(id)")
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView?.frame = mainView.bounds
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    @IBAction func btnBag(_ sender: Any) {
        
        let NextPage = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
        self.navigationController?.pushViewController(NextPage, animated: false)
    }
    //MARK:- collectionView method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExperienceCollectionViewCell", for: indexPath) as! ExperienceCollectionViewCell
        let dict = arrList.object(at: indexPath.row) as! NSDictionary
        let name = dict["name"] as! String
        cell.lblName.text = name
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
        
        cell.imageScond.sd_setShowActivityIndicatorView(true)
        cell.imageScond.sd_setIndicatorStyle(.gray)
        cell.imageScond?.sd_setImage(with: imageUrl) { (image, error, cache, urls) in
            if (error != nil) {
                cell.imageScond.image = #imageLiteral(resourceName: "4")
                cell.lblName.text = name
                cell.imageScond.sd_setShowActivityIndicatorView(false)
            } else {
                cell.imageScond.image = image
                cell.imageScond.sd_setShowActivityIndicatorView(false)
            }
        }
        
        cell.image.layer.masksToBounds = true
        cell.image.layer.borderWidth = 0.0
        cell.image.layer.shadowColor = #colorLiteral(red: 0.5568627451, green: 0.007843137255, blue: 0.1215686275, alpha: 1)
        cell.image.layer.shadowOpacity = 1
        cell.image.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.image.layer.shadowRadius = 5
        
        
        cell.imageScond.layer.masksToBounds = false
        cell.imageScond.layer.borderWidth = 0.0
        
        // cell.image.backgroundColor = UIColor.white
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
        let dict = arrList.object(at: indexPath.row) as? NSDictionary
        
        let NextPage = self.storyboard?.instantiateViewController(withIdentifier: "SuggestionListViewController") as! SuggestionListViewController
        NextPage.selectedType =  dict!["name"] as! String
        NextPage.dataCategories = dict as! NSDictionary
        
        self.navigationController?.pushViewController(NextPage, animated: false)
        
    }
    
    /**************************************************************************/
    //MARK:-  ApI Call ///
    /**************************************************************************/
    func listSubsub2Categories_API(type:String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let parameters: Parameters = ["id" : type]
        let urlString = listSubsubCategories2forfoodPairing
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.SubsubCategoriesAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.SubsubCategoriesAPICallError(error)
            }
        }
    }
    func SubsubCategoriesAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["Message"] as! String
        if (status == 1) {
            let userdata = data!["list"] as! NSArray
            for i in userdata{
                arrList.add(i as! NSDictionary)
            }
            collectionView.reloadData()
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
    }
    func SubsubCategoriesAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "Internet is not responding. Please check the connection.")
    }
    
}
