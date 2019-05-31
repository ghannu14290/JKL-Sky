//
//  AllowedBagsScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 17/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import QuartzCore
import Alamofire
import SwiftyJSON
import MBProgressHUD



class AllowedBagsScreen: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    //OUTLETS.
    @IBOutlet var backView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var tableView: UITableView!
    
    //OULETS FOR API.
    var bagType = [String]()
    var allowedBags = [String]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //CALL THE API.
        self.allowedBagsApi()

        
        //NAVIGATION BAR
        self.navigationItem.title = "Allowed Bags for Allocation"
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

        
        //CHANGE BORDER OF HEADER VIEW.
        headerView.layer.borderColor = UIColor.lightGray.cgColor
        headerView.layer.borderWidth = 0.5;
        
        //CALL THE TABLEVIEW DELEGATE.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BagsTableViewCell")
        
        
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
        return allowedBags.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "BagsTableViewCell")
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5;
        
        
        //PRODUCT NAME
        let productName = UILabel(frame: CGRect(x: 0, y:15, width: 130, height: 21))
        productName.textAlignment = .center
        productName.text = self.bagType[indexPath.row]
        productName.textColor=UIColor.black
        productName.font=UIFont.systemFont(ofSize: 12)
        cell.contentView.addSubview(productName)
        
        
        //PARTITION LINE
        let line = UILabel(frame: CGRect(x: 133, y:0, width: 1, height: 39))
        line.backgroundColor = UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)
        cell.contentView.addSubview(line)
        
        
        //ALLOWED BAGS
        let allowedBags = UILabel(frame: CGRect(x: 190, y:15, width: 190, height: 21))
        allowedBags.textAlignment = .left
        allowedBags.text = self.allowedBags[indexPath.row]
        allowedBags.textColor=UIColor.black
        allowedBags.font=UIFont.systemFont(ofSize: 12)
        cell.contentView.addSubview(allowedBags)
        
        
        return cell;
        
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    
    //ALLOWED BAGS API.
    func allowedBagsApi()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        
        let postString = Common.BaseUrl + "ViewBagDetails"
        
        let newTodo: [String: Any] =  ["UserId": userID] as [String : Any]
        
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
                    
                    let result = swiftyJsonVar["ViewBagDetails"]["Result"].stringValue
                    print(result)
                    
                    
                    for response in swiftyJsonVar["ViewBagDetails"]["Response"].arrayValue
                    {
                        //BAG TYPE
                        let type = response["BagType"].stringValue
                        self.bagType.append(type)
                        print(self.bagType)
                        
                        //ALLOWED NO OF BAGS
                        let bags = response["AllowedNoofBags"].stringValue
                        self.allowedBags.append(bags)
                        print(self.allowedBags)
                        
                    }
                    
                    
                    if swiftyJsonVar["ViewBagDetails"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                        self.tableView.reloadData()
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
