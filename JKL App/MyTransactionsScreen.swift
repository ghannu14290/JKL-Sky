//
//  MyTransactionsScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 17/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD



@available(iOS 10.0, *)
class MyTransactionsScreen: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    //OUTLETS.
     @IBOutlet var tableview: UITableView!
    
    //OUTLETS FOR API.
    var error_code : Int = 0
    var Response = NSArray()
    var totalPoints = String()
    var totalQuantity = [String]()
    var transactionDate = [String]()
    var transactionID = [String]()
    var campaignName = [String]()
    var pointEarn = [String]()
    var pointSpent = [String]()
    
    //VALUES FROM PREVIOUS VIEW CONZTROLLER.
    var FromString: String!
    var toString: String!
    var userId = String()
    var mobileNUmber = String()
    var checkViewController: String! = "leftmenu"
    var checkMemberType = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //CALL API METHOD.
        self.accountStatemnt()
        
        print("USERID \(userId)")
        print("MOB NUmber\(mobileNUmber)")
        
        //NAVIGATION BAR
        self.navigationItem.title = "Account Statement"
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 32/255, green: 95/255, blue: 166/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        //BACKBUTTON ON NAVIGATION BAR.
        let backButn: UIButton = UIButton()
        backButn.setImage(UIImage(named: "ic_action_back (1)"), for: .normal)
        backButn.frame = CGRect(x: 0,y: 0,width: 30,height: 30)
        backButn.addTarget(self, action: #selector(back), for:.touchUpInside)
        backButn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20.0, bottom: 0, right: 13.0)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: backButn), animated: true)
        
        
        //REGISTER TABLEVIEW CELL AND SET THE TABLEVIEW DELEGATE AND DATASOURCE.
        tableview.delegate      =   self
        tableview.dataSource    =   self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        
        
    }
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //DELEGATE METHODS OF TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
         return self.transactionID.count
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "TransactionTableViewCell")
        
      
        //SET THE CELL TEXT ACCORDING TO REATILER AND DEALER.
        let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
        
            if membertype == "D"
            {
                cell.backgroundView = UIImageView(image: UIImage(named: "ios_block_new"))
                cell.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                
                
                //USERDEFAULT NAME OF DEALER
                let username = UserDefaults.standard.object(forKey:"memberName") as! String
                print(username)
                
                
                if checkViewController == "ViewMember"
                {
                    
                    //NAME IN USERDEFAULT.
                    let name = UserDefaults.standard.object(forKey:"nameString") as! String
                    print(name)
                    
                    let dealerName = UILabel(frame: CGRect(x: 16, y:22, width: 115, height: 20))
                    dealerName.textAlignment = .left
                    dealerName.text = name
                    dealerName.textColor=UIColor.darkGray
                    dealerName.font=UIFont.boldSystemFont(ofSize: 14)
                    cell.contentView.addSubview(dealerName)

                }
                else
                {
                    
                }
                
              
                
                
            //TRASACTION DATE
            let transDate = UILabel(frame: CGRect(x: 16, y:45, width: 200, height: 20))
            transDate.textAlignment = .left
            let dateString =  self.transactionDate[indexPath.row]
            let endIndex = dateString.index(dateString.endIndex, offsetBy: -5)
            let date = dateString.substring(to: endIndex)
            transDate.text = "Transaction Date : \(date)"
            transDate.textColor=UIColor.darkGray
            transDate.font=UIFont.systemFont(ofSize: 11)
            cell.contentView.addSubview(transDate)
                
                
                
            //TRASACTION ID
            let transID = UILabel(frame: CGRect(x: 16, y:66, width: 200, height: 20))
            transID.textAlignment = .left
            transID.text = "Transaction ID : \( self.transactionID[indexPath.row])"
            transID.textColor=UIColor.darkGray
            transID.font=UIFont.systemFont(ofSize: 11)
            cell.contentView.addSubview(transID)
                
                
            //PRODUCT NAME
            let productName = UILabel(frame: CGRect(x: 16, y:87, width: 300, height: 20))
            productName.textAlignment = .left
            productName.text = "Campaign/Product Name : \(self.campaignName[indexPath.row])"
            productName.textColor=UIColor.darkGray
            productName.font=UIFont.systemFont(ofSize: 11)
            cell.contentView.addSubview(productName)
                
                
            //NO. OF BAGS
            let numberOfBags = UILabel(frame: CGRect(x: 16, y:107, width: 300, height: 20))
            numberOfBags.textAlignment = .left
            if checkMemberType == "Influencer"
            {
                numberOfBags.text = "No. of Bag : \(self.totalQuantity[indexPath.row])"

            }
                else
            {
            numberOfBags.text = "No. of MT : \(self.totalQuantity[indexPath.row])"
                }
            numberOfBags.textColor=UIColor.darkGray
            numberOfBags.font=UIFont.systemFont(ofSize: 11)
            cell.contentView.addSubview(numberOfBags)
                
                
                
            //POINT EARN
            let pointEarn = UILabel(frame: CGRect(x: 195, y:22, width: 200, height: 20))
            pointEarn.textAlignment = .left
            pointEarn.text = "Points Earned : \(self.pointEarn[indexPath.row])"
            pointEarn.textColor=UIColor.darkGray
            pointEarn.font=UIFont.boldSystemFont(ofSize: 11)
            cell.contentView.addSubview(pointEarn)
            pointEarn.lineBreakMode = .byWordWrapping
            
                
                
            //POINT SPENT
            let pointSpent = UILabel(frame: CGRect(x: 195, y:45, width: 200, height: 20))
            pointSpent.textAlignment = .left
            pointSpent.text = "Points Spent : \(self.pointSpent[indexPath.row])"
            pointSpent.textColor=UIColor.darkGray
            pointSpent.font=UIFont.boldSystemFont(ofSize: 11)
            cell.contentView.addSubview(pointSpent)
            pointSpent.lineBreakMode = .byWordWrapping
            
                
                
                
                
            }
            else if membertype == "R"
            {
                cell.backgroundView = UIImageView(image: UIImage(named: "ios_block_new"))
                cell.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                
                
//                
//                //USERDEFAULT NAME OF DEALER
//                let username = UserDefaults.standard.object(forKey:"memberName") as! String
//                print(username)
//                
//                
//                let dealerName = UILabel(frame: CGRect(x: 16, y:22, width: 115, height: 20))
//                dealerName.textAlignment = .left
//                dealerName.text = username
//                dealerName.textColor=UIColor.darkGray
//                dealerName.font=UIFont.boldSystemFont(ofSize: 14)
//                cell.contentView.addSubview(dealerName)
                
                //TRASACTION DATE
                let transDate = UILabel(frame: CGRect(x: 16, y:45, width: 200, height: 20))
                transDate.textAlignment = .left
                let dateString =  self.transactionDate[indexPath.row]
                let endIndex = dateString.index(dateString.endIndex, offsetBy: -5)
                let date = dateString.substring(to: endIndex)
                transDate.text = "Transaction Date : \(date)"
                transDate.textColor=UIColor.darkGray
                transDate.font=UIFont.systemFont(ofSize: 11)
                cell.contentView.addSubview(transDate)
                
                
                
                //TRASACTION ID
                let transID = UILabel(frame: CGRect(x: 16, y:66, width: 200, height: 20))
                transID.textAlignment = .left
                transID.text = "Transaction ID : \( self.transactionID[indexPath.row])"
                transID.textColor=UIColor.darkGray
                transID.font=UIFont.systemFont(ofSize: 11)
                cell.contentView.addSubview(transID)
                
                
                //PRODUCT NAME
                let productName = UILabel(frame: CGRect(x: 16, y:87, width: 300, height: 20))
                productName.textAlignment = .left
                productName.text = "Campaign/Product Name : \(self.campaignName[indexPath.row])"
                productName.textColor=UIColor.darkGray
                productName.font=UIFont.systemFont(ofSize: 11)
                cell.contentView.addSubview(productName)
                
                
                //NO. OF BAGS
                let numberOfBags = UILabel(frame: CGRect(x: 16, y:107, width: 300, height: 20))
                numberOfBags.textAlignment = .left
                numberOfBags.text = "No. of Bags : \(self.totalQuantity[indexPath.row])"
                numberOfBags.textColor=UIColor.darkGray
                numberOfBags.font=UIFont.systemFont(ofSize: 11)
                cell.contentView.addSubview(numberOfBags)
                
                
                
                //POINT EARN
                let pointEarn = UILabel(frame: CGRect(x: 195, y:22, width: 200, height: 20))
                pointEarn.textAlignment = .left
                pointEarn.text = "Points Earned : \(self.pointEarn[indexPath.row])"
                pointEarn.textColor=UIColor.darkGray
                pointEarn.font=UIFont.boldSystemFont(ofSize: 11)
                cell.contentView.addSubview(pointEarn)
                pointEarn.lineBreakMode = .byWordWrapping

                
                
                
                //POINT SPENT
                let pointSpent = UILabel(frame: CGRect(x: 195, y:45, width: 200, height: 20))
                pointSpent.textAlignment = .left
                pointSpent.text = "Points Spent : \(self.pointSpent[indexPath.row])"
                pointSpent.textColor=UIColor.darkGray
                pointSpent.font=UIFont.boldSystemFont(ofSize: 11)
                cell.contentView.addSubview(pointSpent)
                pointSpent.lineBreakMode = .byWordWrapping

                
                
                
            }
      
        
        return cell;
        
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }


    //MY ACCCOUNT STATEMENT.
    func accountStatemnt()
    {
        
        let postString = Common.BaseUrl + "AccountStatement"
        
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        let mob = UserDefaults.standard.object(forKey:"mobileNumber") as! String
        print(mob)
        
        let newTodo: [String: Any]
        
        if checkViewController == "leftmenu" 
        {
            newTodo =  ["UserId": userID,
                        "MobileNumber" : mob,
                        "FromDate": FromString,
                        "ToDate": toString] as [String : Any]
        }
        else
        {
            newTodo =  ["UserId": userId,
                        "MobileNumber" : mobileNUmber,
                        "FromDate": FromString,
                        "ToDate": toString] as [String : Any]
        }
       
        
        print(newTodo)
        self.showProgress()
        
        
        let user = "lakshya"
        let password = "lakshya@001"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        
        Alamofire.request(postString, method: .post, parameters: newTodo,
                          
                          encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON { response in
                
                
                if((response.result.value) != nil)
                {
                    self.hideProgress()
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    
                    self.error_code = swiftyJsonVar["AccountStatement"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                    self.totalPoints = swiftyJsonVar["AccountStatement"]["TotalPoints"].stringValue
                    print(self.totalPoints)
                    
                    
                    let result = swiftyJsonVar["AccountStatement"]["Result"].stringValue
                    print(result)
                    
                    
                    self.Response = swiftyJsonVar["AccountStatement"]["Response"].arrayValue as NSArray
                    print(self.Response)
                    
                    
                    for response in swiftyJsonVar["AccountStatement"]["Response"].arrayValue
                    {
                        //TOTAL QUANTITY.
                        let quantity = response["NoofMT"].stringValue
                        self.totalQuantity.append(quantity)
                        print(self.totalQuantity)
                        
                        //TRANSACTION DATE.
                        let trnsDate = response["TransactionDate"].stringValue
                        self.transactionDate.append(trnsDate)
                        print(self.transactionDate)
                        
                        //TRANSACTION ID.
                        let trnsID = response["TransactionId"].stringValue
                        self.transactionID.append(trnsID)
                        print(self.transactionID)
                        
                        //CAMPAIGN PRODUCT NAME.
                        let campaignPName = response["CampaignProductName"].stringValue
                        self.campaignName.append(campaignPName)
                        print(self.campaignName)
                        
                        //POINT EARN.
                        let pointEarn = response["PointEarn"].stringValue
                        self.pointEarn.append(pointEarn)
                        print(self.pointEarn)
                        
                        //POINT SPENT.
                        let pointSpent = response["PointSpent"].stringValue
                        self.pointSpent.append(pointSpent)
                        print(self.pointSpent)
                        
                        
                    }
                    
                    if swiftyJsonVar["AccountStatement"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                        self.tableview.reloadData()
                    }
                        
                    else
                    {
                        self.hideProgress()
                        
                        //SHOW ALERT
                        let alert = UIAlertController(title:"", message:result , preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                            
                            //MOVE TO HOME SCREEN
                            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! HomeScreen
                            self.navigationController?.pushViewController(secondViewController, animated: true)
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.leftmenu()
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                    
                }
                
                
        }
        
        
    }
    
    
    //PROGRESS BAR.
    func showProgress()
    {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
    }
    
    
    func hideProgress()
    {
        
        MBProgressHUD.hide(for: self.view, animated: true)
        
    }
    
    
}
