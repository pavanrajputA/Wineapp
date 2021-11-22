//
//  HistoryDetailsViewController.swift
//  Wine
//
//  Created by Apple on 06/09/21.
//

import UIKit

class HistoryDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
                                        
   var arrListSend : NSMutableArray = NSMutableArray()
   var cardID_str = ""
   var dicForrecipt : NSDictionary = NSDictionary()
   var dicForAddress : NSDictionary = NSDictionary()
   
   @IBOutlet weak var tblView: UITableView!
   var arrListReceipt :NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = true
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "ReceiptTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiptTableViewCell")
        tblView.register(UINib(nibName: "TotalPriceReceiptTableViewCell", bundle: nil), forCellReuseIdentifier: "TotalPriceReceiptTableViewCell")
   
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.pop(animated: true)

    }

}
extension HistoryDetailsViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  section == 1 {
            return 1
        }else{
            return arrListReceipt.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
                // Updates
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TotalPriceReceiptTableViewCell", for: indexPath) as? TotalPriceReceiptTableViewCell else { return UITableViewCell() }
            cell.viewFortotal.layer.borderWidth = 1
            cell.viewFortotal.layer.borderColor = #colorLiteral(red: 0, green: 0.3176470588, blue: 0.8588235294, alpha: 1)

            cell.lblShippingcharges.text = "$" + "\(dicForrecipt.GotValue(key: "shippingCharge") as String)"
            cell.lblStatetax.text = "(\(dicForrecipt.GotValue(key: "stateTaxParsent") as String)" + "%)"
            cell.lblStatePrice.text = "$" + "\(dicForrecipt.GotValue(key: "stateRate") as String)"
            cell.lblTotalamount.text = "$" + "\(dicForrecipt.GotValue(key: "total") as String)"
            cell.lblOrdernumber.text = "\(dicForrecipt.GotValue(key: "orderId") as String)"

            
            
            cell.lblFullName.text = "Name : " + "\(dicForAddress.GotValue(key: "fullname") as String)"
            cell.lblAddress1.text = "Address : " + "\(dicForAddress.GotValue(key: "address1") as String)"
            cell.lblCity.text = "City : " + "\(dicForAddress.GotValue(key: "city") as String)"
            cell.lblState.text = "State : " + "\(dicForAddress.GotValue(key: "state") as String)"
            cell.lblZip.text = "ZIP : " + "\(dicForAddress.GotValue(key: "zip") as String)"
            
            cell.lblDate.text = "Date : " + "\(dicForrecipt.GotValue(key: "orderDate") as String)"

            
                return cell
            } else {
                // UpdatesTask
                guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "ReceiptTableViewCell", for: indexPath) as? ReceiptTableViewCell else { return UITableViewCell() }
                let dict = arrListReceipt.object(at: indexPath.row) as! NSDictionary
                
                let count = dict.GotValue(key: "count") as! String
                let price = dict.GotValue(key: "price") as! String
                let amount = Float(count)! * Float(price)!
                
                cell2.lblName.text = dict.GotValue(key: "name") as! String
                cell2.lblCount.text = dict.GotValue(key: "count") as! String
                cell2.lblPrice.text = "x $\(dict.GotValue(key: "price") as! String)"
                cell2.lblPrice2.text = "$\(amount)"
                return cell2
            }

        
   
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 1 {
        return 300
    } else {
        return UITableView.automaticDimension
      }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 300
        } else {
            return UITableView.automaticDimension
        }
    }
}
