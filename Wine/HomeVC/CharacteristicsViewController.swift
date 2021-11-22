//
//  CharacteristicsViewController.swift
//  Wine
//
//  Created by Apple on 30/07/21.
//

import UIKit
import Alamofire

class CharacteristicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
    
    @IBOutlet weak var tblView: UITableView!
    var arrList :NSMutableArray = NSMutableArray()
    
    var isBack = true
    var dic1 = NSMutableDictionary()
    
    
    var wineId = NSNumber()
    
    var Str_name = String()
    
    let data = [["0,0", "0,1", "0,2"], ["1,0", "1,1", "1,2"]]
    let headerTitles = ["Some Data 1", "KickAss"]
    

    
   // Floral, Green Fruit, Citrus Fruit, Stone Fruit, Tropical Fruit.
    
    
    let dataw = [["SWIFT", "BALENO", "ALTO", "CIAZ"], ["INNOVA", "GLANZA", "FORTUNER"] , ["BMW X5", "BMW M4", "BMW 7 Series", "BMW X7", "BMW i3"],["Tertiary 1", "Tertiary 2", "Tertiary 3", "Tertiary X7", "Tertiary i3"]]

    let brand: Array<String> = ["Primary Aromas and Tatstes", "Secondary Aromas and Tastes", "Tertiary Aromas and Tastes", "More Info"]

    var arrofarr : NSMutableArray = NSMutableArray()
    var arr_Primary : NSMutableArray = NSMutableArray()
    var arr_Secondary : NSMutableArray = NSMutableArray()
    var arr_Tertiary : NSMutableArray = NSMutableArray()
    var arr_Info : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = true
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "CharacteristicsTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacteristicsTableViewCell")
        
        
        
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
            self.infoVarietals_API(varietalsname: "\(Str_name)")
        }
        
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
    @IBAction func btnBag(_ sender: Any) {
       
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "BagViewController") as! BagViewController
        self.navigationController?.pushViewController(editProfile, animated: false)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrofarr.count
    }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr_temp = arrofarr[section] as! NSMutableArray
           return arr_temp.count
      }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.brand[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1: CharacteristicsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CharacteristicsTableViewCell") as! CharacteristicsTableViewCell
        let arr_main = arrofarr[indexPath.section] as! NSMutableArray
        let dict = arr_main[indexPath.row] as! NSDictionary
        let key = dict.GotValue(key: "key")
        let value = dict.GotValue(key: "value")
        cell1.lblKay.text = key as String
        cell1.lblKay.textAlignment = .natural
        cell1.lblValue.text = value as String
        cell1.lblValue.sizeToFit()
        return cell1
    }
    
    //MARK:-  ApI Call socialLogin///
    /**************************************************************************/
    func infoVarietals_API(varietalsname:String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let parameters: Parameters = [ "varietals" : varietalsname]
        let urlString = characteristicsWine
        let url = URL.init(string: urlString)
        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                self.infoVarietalsAPICallFinished(json as! NSDictionary)
            case .failure(let error):
                self.infoVarietalsAPICallError(error)
            }
        }
    }
    func infoVarietalsAPICallFinished(_ dictPlayersInfo: NSDictionary)
    {
        let data = dictPlayersInfo["data"] as? NSDictionary
        let status = dictPlayersInfo["status"] as! NSNumber
        let message = dictPlayersInfo["message"] as! String
        if (status == 1) {
            let Primary_Aromas_And_Tastes = data!["Primary_Aromas_And_Tastes"] as! NSDictionary
            let Secondary_Aromas_And_Tastes = data!["Secondary_Aromas_And_Tastes"] as! NSDictionary
            let Tertiary_Aromas_And_Tastes = data!["Tertiary_Aromas_And_Tastes"] as! NSDictionary
            let Info = data!["Info"] as! NSDictionary
            
            for i in Primary_Aromas_And_Tastes{
                let key = i.key
                let value = i.value
                let dict = ["key" : key ,"value" : value ]
                arr_Primary.add(dict as! NSDictionary)
            }
            
            for i in Secondary_Aromas_And_Tastes{
                let key = i.key
                let value = i.value
                let dict = ["key" : key ,"value" : value ]
                arr_Secondary.add(dict as! NSDictionary)
            }
            for i in Tertiary_Aromas_And_Tastes{
                let key = i.key
                let value = i.value
                let dict = ["key" : key ,"value" : value ]
                arr_Tertiary.add(dict as! NSDictionary)
            }
            for i in Info{
                let key = i.key
                let value = i.value
                let dict = ["key" : key ,"value" : value ]
                arr_Info.add(dict as! NSDictionary)
            }
            
            arrofarr.add(arr_Primary)
            arrofarr.add(arr_Secondary)
            arrofarr.add(arr_Tertiary)
            arrofarr.add(arr_Info)
            
            print(arrofarr)
            tblView.reloadData()
            
        }else{
            ShowCustomAlert.show(withMessage:message)
        }
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
    }
    func infoVarietalsAPICallError(_ error: Error)
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        ShowCustomAlert.show(withMessage: "\(error)")
    }
    
    
}

