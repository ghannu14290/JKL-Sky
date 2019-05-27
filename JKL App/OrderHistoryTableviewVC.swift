//
//  OrderHistoryTableviewVC.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 31/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD




class OrderHistoryTableviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    //OUTLETS.
    @IBOutlet var tableview: UITableView!
    
    //OUTLETS FOR API.
    var error_code : Int = 0
    var Response = NSArray()
    var orderdtae = [String]()
    var productName = [String]()
    var totalpoints = [String]()
    var ordernNumber = [String]()
    var subOrderId = [String]()
    var shippedAddress = [String]()
    var status = [String]()
    
    
    //VALUES FROM PREVIOUS VIEW CONZTROLLER.
    var FromString: String!
    var toString: String!
    var userId = String()
    var mobileNUmber = String()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //NAVIGATION BAR
        self.navigationItem.title = "Redemption History"
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
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: backButn), animated: true)
        
        //CALL API.
         self.orderhistoryAPI()
        
        
        //REGISTER TABLEVIEW CELL AND SET THE TABLEVIEW DELEGATE AND DATASOURCE.
        tableview.delegate      =   self
        tableview.dataSource    =   self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "OrdrHistoryTableViewCell")
        
        
        
    }
    
    //DELEGATE METHODS OF TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.productName.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "OrdrHistoryTableViewCell")
        
        cell.backgroundView = UIImageView(image: UIImage(named: "ios_block_new"))
        cell.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
            
            //DEALER NAME
            
            
            //USERDEFAULT NAME OF DEALER
            let username = UserDefaults.standard.object(forKey:"memberName") as! String
            print(username)
            
            
            let productName = UILabel(frame: CGRect(x: 16, y:22, width: 115, height: 20))
            productName.textAlignment = .left
            productName.text = self.productName[indexPath.row]
            productName.textColor=UIColor.darkGray
            productName.font=UIFont.boldSystemFont(ofSize: 14)
            cell.contentView.addSubview(productName)
            
            
            //ORDER DATE
            let orderdate = UILabel(frame: CGRect(x: 16, y:45, width: 300, height: 20))
            orderdate.textAlignment = .left
            let ordrDate = self.orderdtae[indexPath.row]
            orderdate.text = "Order Date : \(ordrDate)"
            orderdate.textColor=UIColor.darkGray
            orderdate.font=UIFont.systemFont(ofSize: 11)
            cell.contentView.addSubview(orderdate)
            
        
            
            //ORDER NUMBER
            let ordernUmber = UILabel(frame: CGRect(x: 16, y:66, width: 300, height: 20))
            ordernUmber.textAlignment = .left
            let orderno = self.ordernNumber[indexPath.row]
            ordernUmber.text = "Order No : \(orderno)"
            ordernUmber.textColor=UIColor.darkGray
            ordernUmber.font=UIFont.systemFont(ofSize: 11)
            cell.contentView.addSubview(ordernUmber)
        
        
        
            //SUBORDER NUMBER
            let suborder = UILabel(frame: CGRect(x: 16, y:87, width: 300, height: 20))
            suborder.textAlignment = .left
            let suborderNumber = self.subOrderId[indexPath.row]
            suborder.text = "Sub Order No : \(suborderNumber)"
            suborder.textColor=UIColor.darkGray
            suborder.font=UIFont.systemFont(ofSize: 11)
            cell.contentView.addSubview(suborder)
        
            
            
            //SHIPPED ADDRESS
            let address = UILabel(frame: CGRect(x: 16, y:102, width: 315, height: 20))
            address.textAlignment = .left
            let shippedAdresss = self.shippedAddress[indexPath.row]
            address.text = "\(shippedAdresss)"
            address.textColor=UIColor.darkGray
            address.numberOfLines = 0
            address.sizeToFit()
            address.lineBreakMode = .byWordWrapping
            address.font=UIFont.systemFont(ofSize: 11)
            cell.contentView.addSubview(address)
        
        
            //TOTAL POINTS
            let totalpoints = UILabel(frame: CGRect(x: 200, y:22, width: 150, height: 20))
            totalpoints.textAlignment = .left
            let points = self.totalpoints[indexPath.row]
            totalpoints.text = "Total Points : \(points)"
            totalpoints.textColor=UIColor.darkGray
            totalpoints.font=UIFont.boldSystemFont(ofSize: 11)
            cell.contentView.addSubview(totalpoints)
        
            
            //STATUS
            let Orderstatus = UILabel(frame: CGRect(x: 200, y:45, width: 150, height: 20))
            Orderstatus.textAlignment = .left
            let Status = self.status[indexPath.row]
            Orderstatus.text = "Status : \(Status)"
            Orderstatus.textColor=UIColor.darkGray
            Orderstatus.font=UIFont.boldSystemFont(ofSize: 11)
            cell.contentView.addSubview(Orderstatus)
        
        
            
        
        return cell;
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    

    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        self.navigationController?.popViewController(animated: true)
    }

    
    //ORDER HISTORY API.
    func orderhistoryAPI()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        
        let postString = "http://jklsky.com/api/Service.svc/OrderHistory"
        
        let newTodo: [String: Any] =  ["UserId":userID,
                                       "FromDate": FromString,
                                       "ToDate":toString] as [String : Any]
        
        print(newTodo)
        self.showProgress()
        
        let user = "lakshya"
        let password = "lakshya@001"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        self.showProgress()
        
        Alamofire.request(postString, method: .post, parameters: newTodo,
                          
                          encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON { response in
                
                
                if((response.result.value) != nil)
                {
                    self.hideProgress()
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    
                    self.error_code = swiftyJsonVar["OrderHistory"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                    let result = swiftyJsonVar["OrderHistory"]["Result"].stringValue

                    
                    for response in swiftyJsonVar["OrderHistory"]["Response"].arrayValue
                    {
                        //ORDER DATE.
                        let orderDate = response["OrderDate"].stringValue
                        self.orderdtae.append(orderDate)
                        print(self.orderdtae)
                        
                        //PRODUCT NAME.
                        let pName = response["ProductName"].stringValue
                        self.productName.append(pName)
                        print(self.productName)
                        
                        //TOTAL POINTS.
                        let totalpoint = response["TotalPoint"].stringValue
                        self.totalpoints.append(totalpoint)
                        print(self.totalpoints)
                        
                        //ORDER NUMBER.
                        let orderNo = response["OrderNumber"].stringValue
                        self.ordernNumber.append(orderNo)
                        print(self.ordernNumber)
                        
                        //SUBORDER ID.
                        let subID = response["SuborderId"].stringValue
                        self.subOrderId.append(subID)
                        print(self.subOrderId)
                        
                        //SHIPPED ADDRESS.
                        let shippedaddress = response["ShippedAddress"].stringValue
                        self.shippedAddress.append(shippedaddress)
                        print(self.shippedAddress)
                        
                        //STATUS.
                        let Status = response["Status"].stringValue
                        self.status.append(Status)
                        print(self.status)
                    }
                    
                    if swiftyJsonVar["OrderHistory"]["Result"].stringValue == "Success"
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
