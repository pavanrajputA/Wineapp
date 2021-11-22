//
//
//  StartUpView.swift
//  Wine
//
//  Created by Apple on 13/07/21.//

import UIKit

class StartUpView: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imgScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    
    @IBOutlet weak var imagView: UIView!
    
    @IBOutlet weak var lblDes: UILabel!
   // var arrImages : [UIImage] = []
    let arrImages = ["Img1", "Img2", "Img3"]
    let arrDes = ["Simplifies Wine Selection by recommending grape varietals and bottles through the application of AI selection criteria best suited to enhance your Experiences, Food Pairings and to Extend your Palate and Enjoyment of Wine.", "Grow your wine knowledge", "MeSomm is the Wine Sommelier in your pocket"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // get images from path and add it in array
//        let fm = FileManager.default
//        let path = Bundle.main.resourcePath! + "/Images"
//           
//        print(path)
//        do{
//            let item = try fm.contentsOfDirectory(atPath: path).filter{$0.lowercased().hasSuffix(".png") || $0.lowercased().hasSuffix(".jpg")}
//            print(item)
//            arrImages.removeAll()
//            for imgs in item{
//                print(imgs)
//                arrImages.append(UIImage(named:"Images/\(imgs)")!)
//                print(arrImages)
//            }
//        }catch let e{
//            print("error  : \(e)")
//        }
        btnNext.isHidden = true
        btnPrevious.isHidden = true
        btnSkip.roundCorners()
        btnContinue.roundCorners()
        loadScrollView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    // Loading image in scrollview
    func loadScrollView() {
        let pageCount = arrImages.count
        imgScrollView.frame = view.bounds
        imgScrollView.delegate = self
        imgScrollView.backgroundColor = UIColor.clear
        imgScrollView.isPagingEnabled = true
        imgScrollView.showsHorizontalScrollIndicator = false
        imgScrollView.showsVerticalScrollIndicator = false
        
        pageControl.numberOfPages = pageCount
        pageControl.currentPage = 0
        
        for i in (0..<pageCount) {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: i * Int(self.imagView.frame.size.width) , y: 0 , width:
                Int(self.imagView.frame.size.width) , height: Int(self.imagView.frame.size.height))
            imageView.contentMode = .scaleAspectFit
            
            imagView.layer.cornerRadius = imagView.frame.size.height/2
            imagView.layer.masksToBounds = true
            imagView.layer.borderWidth = 0.0
            
            imageView.image =  UIImage(named: arrImages[i])
            lblDes.text = arrDes[0]
            print(arrDes[i])
//            imageView.backgroundColor = UIColor.white
            self.imgScrollView.addSubview(imageView)
        }
        
        let width1 = (Float(arrImages.count) * Float(self.imagView.frame.size.width))
        imgScrollView.contentSize = CGSize(width: CGFloat(width1), height: self.imagView.frame.size.height + 50)

        self.pageControl.addTarget(self, action: #selector(self.pageChanged(sender:)), for: UIControl.Event.valueChanged)
                
    }
    
    //MARK: -
    // Scrollview Delegate method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imgScrollView.contentOffset.y = 0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print(pageNumber)
        if  pageControl.currentPage == arrImages.count - 1{
            btnContinue.setTitle("Get Started", for: .normal)
            
            btnSkip.isHidden = true
        }
        else{
            btnContinue.setTitle("Continue", for: .normal)
            btnSkip.isHidden = false
        }
        
        if  pageNumber == 0{
            lblDes.text = arrDes[0]
            print(lblDes.text)
        }else if  pageNumber == 1{
            lblDes.text = arrDes[1]
            print(lblDes.text)
        }else if  pageNumber == 2{
            lblDes.text = arrDes[2]
            print(lblDes.text)
        }
        
   
    }
    
    @objc func pageChanged(sender:AnyObject)
    {
        let xVal = CGFloat(pageControl.currentPage) * imgScrollView.frame.size.width
        imgScrollView.setContentOffset(CGPoint(x: xVal, y: 0), animated: true)
        
    }
    
    //change page number on click of button
    func changedPageNumber(){
        let pageNumber = round(imgScrollView.contentOffset.x / imagView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print(pageNumber)
        if  pageNumber == 0{
            lblDes.text = arrDes[0]
            print(lblDes.text)
        }else if  pageNumber == 1{
            lblDes.text = arrDes[1]
            print(lblDes.text)
        }else if  pageNumber == 2{
            lblDes.text = arrDes[2]
            print(lblDes.text)
        }
        
        
        if  pageControl.currentPage == arrImages.count - 1{
            btnContinue.setTitle("Get Started", for: .normal)
            btnSkip.isHidden = true
        }
        else{
            btnContinue.setTitle("Continue", for: .normal)
        }
    }
    
    // On tap display previous image
    @IBAction func btnPreviousTapped(_ sender: Any){
        if pageControl.currentPage > 0 {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.imgScrollView.contentOffset.x = self.imgScrollView.contentOffset.x - self.imagView.frame.size.width
            })
           changedPageNumber()
        }
    }
    
     // On tap display next image
    @IBAction func btnNextTapped(_ sender: Any) {
        
        if pageControl.currentPage < self.arrImages.count - 1 {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.imgScrollView.contentOffset.x = self.imgScrollView.contentOffset.x + self.imagView.frame.size.width
            })
            
            changedPageNumber()
        }
    }
    //On skip load welcome page
    @IBAction func btnSkipTapped(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard

        userDefaults.set("YES", forKey: "isWelcome")
        
        let story:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginView:KYDrawerController = (story.instantiateViewController(withIdentifier: "KYDrawerController") as? KYDrawerController)!
        self.navigationController?.pushViewController(LoginView, animated: true)
        
        
        
    }
    // On continue it will show next image
    @IBAction func btnContinueTapped(_ sender: Any) {
        if btnContinue.titleLabel?.text == "Get Started"{
            
            let userDefaults = UserDefaults.standard
    
            userDefaults.set("YES", forKey: "isWelcome")
            
            let story:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let LoginView:KYDrawerController = (story.instantiateViewController(withIdentifier: "KYDrawerController") as? KYDrawerController)!
            
            self.navigationController?.pushViewController(LoginView, animated: true)
        }
        else{
            if pageControl.currentPage < self.arrImages.count - 1 {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.imgScrollView.contentOffset.x = self.imgScrollView.contentOffset.x + self.imagView.frame.size.width
                })
               changedPageNumber()
            }
        }
    }
}
extension UIButton {
    func roundCorners() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
}
