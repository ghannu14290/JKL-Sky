//
//  AllocationHistoryVC.swift
//  JKL App
//
//  Created by New User on 1/12/18.
//  Copyright © 2018 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class AllocationHistoryVC: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    var error_code : Int = 0
    var allocationArray = [JSON]()
    @IBOutlet var tableview: UITableView!
    var FromString: String!
    var toString: String!
    var userId = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Allocation History"
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
        
        //CALL API.
        self.allocationHistoryAPI()
        //REGISTER TABLEVIEW CELL AND SET THE TABLEVIEW DELEGATE AND DATASOURCE.
        tableview.delegate      =   self
        tableview.dataSource    =   self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "OrdrHistoryTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    @objc func back()
    {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.allocationArray.count
        
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
        
      
        
        let productName = UILabel(frame: CGRect(x: 16, y:22, width: 300, height: 20))
        productName.textAlignment = .left
        let productName1 = self.allocationArray[indexPath.row]["ProductName"].stringValue
        productName.text = "Product Name : \(productName1)"
        productName.textColor=UIColor.darkGray
        productName.font=UIFont.systemFont(ofSize: 11)
        cell.contentView.addSubview(productName)

        //ORDER DATE
        let Allocatedbags = UILabel(frame: CGRect(x: 16, y:45, width: 300, height: 20))
        Allocatedbags.textAlignment = .left
        let Allocatedbags1 = self.allocationArray[indexPath.row]["NoofBags"].stringValue
        Allocatedbags.text = "Allocated no. of bags : \(Allocatedbags1)"
        Allocatedbags.textColor=UIColor.darkGray
        Allocatedbags.font=UIFont.systemFont(ofSize: 11)
        cell.contentView.addSubview(Allocatedbags)
        
        
        let Allocatedid = UILabel(frame: CGRect(x: 16, y:66, width: 300, height: 20))
        Allocatedid.textAlignment = .left
        let Allocatedid1 = self.allocationArray[indexPath.row]["AllocatedId"].stringValue
        Allocatedid.text = "Allocated ID : \(Allocatedid1)"
        Allocatedid.textColor=UIColor.darkGray
        Allocatedid.font=UIFont.systemFont(ofSize: 11)
        cell.contentView.addSubview(Allocatedid)
        
        let Allocateddate = UILabel(frame: CGRect(x: 16, y:87, width: 300, height: 20))
        Allocateddate.textAlignment = .left
        let Allocateddate1 = self.allocationArray[indexPath.row]["AllocationDate"].stringValue
        Allocateddate.text = "Allocated Date : \(Allocateddate1)"
        Allocateddate.textColor=UIColor.darkGray
        Allocateddate.font=UIFont.systemFont(ofSize: 11)
        cell.contentView.addSubview(Allocateddate)
        //ORDER NUMBER
        
        let influencerId = UILabel(frame: CGRect(x: 16, y:108, width: 300, height: 20))
        influencerId.textAlignment = .left
        let influencerId1 = self.allocationArray[indexPath.row]["AllocationDate"].stringValue
        influencerId.text = "Influencer ID : \(influencerId1)"
        influencerId.textColor=UIColor.darkGray
        influencerId.font=UIFont.systemFont(ofSize: 11)
        cell.contentView.addSubview(influencerId)

        
        return cell;
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }

    func allocationHistoryAPI()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        
        let postString = Common.BaseUrl + "AllocationHistory"
     //   let postString = "http://jklakshmidemo.netcarrots.in/API/Service.svc/AllocationHistory"
        let newTodo: [String: Any] =  ["UserId":userID,
                                       "FromDate": FromString,
                                       "ToDate":toString] as [String : Any]
        
        print(newTodo)
        
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
                    
                    self.error_code = swiftyJsonVar["AllocationHistory"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                    let result = swiftyJsonVar["AllocationHistory"]["Result"].stringValue
                    
                    
                    
                    if swiftyJsonVar["AllocationHistory"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                        self.allocationArray = swiftyJsonVar["AllocationHistory"]["Response"].array!
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
        MBProgressHUD.hide(for: self.tableview, animated: true)

    }

}
