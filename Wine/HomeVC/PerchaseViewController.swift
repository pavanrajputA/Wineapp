//
//  PerchaseViewController.swift
//  Wine
//
//  Created by Apple on 29/07/21.
//

import UIKit
import Alamofire

class PerchaseViewController: UIViewController {
    @IBOutlet weak var lblDescripation: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    var numberCount = 1
    @IBOutlet weak var lblCounnt: UILabel!
    @IBOutlet weak var lblNamewine: UILabel!
    @IBOutlet weak var ViewLast: UIView!
    @IBOutlet weak var ViewPluseMinus: UIView!
    @IBOutlet weak var btnAddtocart: UIButton!
    @IBOutlet weak var lblReviewcount: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var viewReview: FloatRatingView!
    @IBOutlet weak var lblPriceofdate: UILabel!
    
    @IBOutlet weak var winImage: UIImageView!
    var isBack = true
    var dicNewdata: NSDictionary = NSDictionary()
    var winId = NSNumber()
    
    @IBOutlet weak var btnBagCount: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var price = lblPrice.text
        var totl = Double(price!)! * Double(numberCount)
        lblTotal.text = "\(totl)"

        
        ViewPluseMinus.layer.cornerRadius = 20.0

        ViewPluseMinus.layer.borderWidth = 1.0
        ViewPluseMinus.layer.borderColor = UIColor.black.cgColor
        ViewPluseMinus.layer.masksToBounds = true
        btnAddtocart.layer.cornerRadius = 20
        
        
        lblNamewine.text = dicNewdata["name"] as! String
        lblNamewine.adjustsFontSizeToFitWidth = true
        winId = dicNewdata["id"] as! NSNumber
        lblPrice.text = "$\(dicNewdata["prize"] as! Double)"
        lblReview.text = "\(dicNewdata["reviews"] as! NSNumber) Reviews"
        viewReview.rating =  Double(dicNewdata["rating_count"] as! NSNumber)
        viewReview.isUserInteractionEnabled = false
        lblReviewcount.text = "\(dicNewdata["rating_count"] as! NSNumber).0"
        //lblPriceofdate.text = "Price of \(dicNewdata["date"] as! String)"
        lblPriceofdate.text = "Price of \(dicNewdata.GotValue(key: "date" as! String))"
        
        
        let imageURL =  imagePath + "\(dicNewdata.GotValue(key: "image") as String)"
        var imageUrl: URL? {
            if let url = URL(withCheck: imageURL) {
                return url
            }
            if let url = URL(withCheck: imageURL) {
                return url
            }
            return nil
        }
        
        winImage.sd_setShowActivityIndicatorView(true)
        winImage.sd_setIndicatorStyle(.gray)
        
        winImage?.sd_setImage(with: imageUrl) { [self] (image, error, cache, urls) in
                if (error != nil) {
                    winImage.image = #imageLiteral(resourceName: "4")
                    winImage.sd_setShowActivityIndicatorView(false)
                } else {
                    winImage.image = image
                    winImage.sd_setShowActivityIndicatorView(false)
                }
            }
        lblDescripation.text = dicNewdata.GotValue(key: "discription") as! String
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if APPDELEGATE.isBack == true {
            self.navigationController?.popToRoot(animated: false)
            APPDELEGATE.isBack = false
        }else{
            APPDELEGATE.isBack = false
        }
        let localcall = UserDefaults.standard.object(forKey: "userproductdata") as? NSArray ?? []
        
        for i in localcall {
            var winedata = i as! NSDictionary
            var id = winedata["id"] as! NSNumber
            if (dicNewdata["id"] as! NSNumber == id) {
                numberCount = Int(winedata["count"] as! NSNumber)
                lblCounnt.text = "\(numberCount)"
            }else{
                numberCount = 1
                lblCounnt.text = "\(numberCount)"
            }
        }
        
        if localcall.count == 0{
            numberCount = 1
            lblCounnt.text = "\(numberCount)"
        }
        
        let localArrCount = localarrCount()
        btnBagCount.setTitle("\(localArrCount)", for: .normal)
        btnBagCount.setTitleColor(.black, for: .normal)
        
    }
    @IBAction func btnPluse(_ sender: Any) {
        numberCount += 1
        if numberCount == 37{
            numberCount = 36
            lblCounnt.text = "\(numberCount)"
            }
        else if numberCount == 36{
            lblCounnt.text = "\(numberCount)"
        }
    else{
        if numberCount < 10{
            lblCounnt.text = "0\(numberCount)"
            
        }else{
            lblCounnt.text = "\(numberCount)"
        }
        }
        
    //    var price = lblPrice.text
        
        
        
//        var totl = Double(price!)! * Double(numberCount)
//
//
//        lblTotal.text = "\(totl)"
        
    }
    @IBAction func btnMinus(_ sender: Any) {

        numberCount -= 1
        if numberCount == 0{
            numberCount = 1

        }
    
        if numberCount < 10{
            lblCounnt.text = "0\(numberCount)"
        }else{
            lblCounnt.text = "\(numberCount)"
        }
        
//        var price = lblPrice.text
//        var totl = Double(price!)! * Double(numberCount)
//        lblTotal.text = "\(totl)"
    }
    @IBAction func btnAddTocard(_ sender: Any) {
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
       // editProfile.dicDetails = dict! as NSDictionary
        
        let userDefaults = UserDefaults.standard
        let Userdetails = userDefaults.object(forKey: "userproductdata") as? NSDictionary ?? [:]
        print(Userdetails)

        print(dicNewdata)
        
        var dicNewdata: NSDictionary = ["id": winId, "image": dicNewdata["image"] as! String ,"prize": dicNewdata["prize"] as! Double,"name" : dicNewdata["name"] as! String,"count" : numberCount]
        var arrlocl : NSMutableArray = NSMutableArray()
        let localcall = UserDefaults.standard.object(forKey: "userproductdata") as? NSArray ?? []
        
        for i in localcall {
            var winedata = i as! NSDictionary
            var id = winedata["id"] as! NSNumber
            if (dicNewdata["id"] as! NSNumber == id) {
                arrlocl.remove(i)
            }else{
                arrlocl.add(i as! NSDictionary)
            }

        }

        arrlocl.add(dicNewdata)
        
        userDefaults.set(arrlocl, forKey: "userproductdata")
        self.navigationController?.pushViewController(editProfile, animated: false)
        
    }
    @IBAction func btnback(_ sender: Any) {
        self.navigationController?.pop(animated: true)
        isBack = true
    }
    @IBAction func btnBag(_ sender: Any) {
       
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
       // editProfile.dicDetails = dict! as NSDictionary
        
        self.navigationController?.pushViewController(editProfile, animated: false)
    }
    
}
class GradientView: UIView {
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
    }
}
