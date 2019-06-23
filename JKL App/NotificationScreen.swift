//
//  NotificationScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 28/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD



@available(iOS 10.0, *)
class NotificationScreen: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    //OUTLETS.
    @IBOutlet var tableview: UITableView!
    
    //VALUES FOR API.
    var notificationId = [String]()
    var notificationresponse = [String]()
    var notificationContent = [String]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //NAVIGATION BAR
        self.navigationItem.title = "Notifications"
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
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "NotificationTableViewCell")
        
        //CAll NOTIFICATION API.
        self.notificationApi()
        
        
    
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
        
        return notificationContent.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "NotificationTableViewCell")
        
        cell.backgroundView = UIImageView(image: UIImage(named: "ios_block_new"))
        cell.backgroundColor = UIColor.white
      
            //NOTIFICATION CONTENT
            let content = UILabel(frame: CGRect(x: 15, y:20, width: 351, height: 67))
            content.textAlignment = .left
            content.text = self.notificationContent[indexPath.row]
            content.textColor = UIColor.gray
            content.font=UIFont.systemFont(ofSize: 12)
            cell.contentView.addSubview(content)
            content.numberOfLines = 0
            content.lineBreakMode = .byWordWrapping
            content.sizeToFit()
        
        let memberRsponse = self.notificationresponse[indexPath.row]
        
        if memberRsponse == "No"
        {
            
            //INTERESTED BUTTON
            let interested = UIButton(type: UIButtonType.custom) as UIButton
            interested.frame = CGRect(x:15, y:65, width: 110, height: 30)
            //likebutton.addTarget(self, action: #selector(likeBtn), for: UIControlEvents.touchUpInside)
            interested.setTitle("Interested", for: .normal)
            interested.setTitleColor(UIColor.gray, for: .normal)
            interested.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            interested.tag = indexPath.row
            cell.contentView.addSubview(interested)
           interested.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
            interested.layer.borderWidth = 0.5;
            interested.layer.cornerRadius = 5.0;
        
        
           //NOT INTERESTED BUTTON
            let notinterested = UIButton(type: UIButtonType.custom) as UIButton
            notinterested.frame = CGRect(x:143, y:65, width: 110, height: 30)
            //likebutton.addTarget(self, action: #selector(likeBtn), for: UIControlEvents.touchUpInside)
            notinterested.setTitle("Not Interested", for: .normal)
            notinterested.tag = indexPath.row
            notinterested.setTitleColor(UIColor.gray, for: .normal)
            notinterested.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            cell.contentView.addSubview(notinterested)
            notinterested.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
            notinterested.layer.borderWidth = 0.5;
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var r = CGFloat()
        
        let memberRsponse = self.notificationresponse[indexPath.row]
        
        if memberRsponse == "No"
        {
            r = 115
        }
        else
        {
            r = 95
        }
        
        return r
    }

    //NOTIFICATION API.
    func notificationApi()
    {
        //MOBILE NUMBER IN USERDEFAULT.
        let mobileNumber = UserDefaults.standard.object(forKey:"mobileNum") as! String
        print(mobileNumber)
        
        let postString = Common.BaseUrl + "GetNotification"
        
        let newTodo: [String: Any] =  ["MobileNo": mobileNumber] as [String : Any]
        
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
                    
                  
                    let result = swiftyJsonVar["GetNotification"]["Result"].stringValue
                    print(result)
                    
                    
                    
                    for response in swiftyJsonVar["GetNotification"]["Response"].arrayValue
                    {
                        
                        //NOTIFICATION ID.
                        let id = response["NotificationId"].stringValue
                        self.notificationId.append(id)
                        print(self.notificationId)
                        
                        //NOTIFICATION RESPONSE.
                        let mmbrresponse = response["MemberResponse"].stringValue
                        self.notificationresponse.append(mmbrresponse)
                        print(self.notificationresponse)
                        
                        //NOTIFICATION CONTENT.
                        let content = response["NotificationContent"].stringValue
                        self.notificationContent.append(content)
                        print(self.notificationContent)
                        
                    }
                    
                    if swiftyJsonVar["GetNotification"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                        
                        self.tableview.reloadData()
                        
                        
                        
                    }
                        
                    else
                    {
                        self.hideProgress()
                        //SHOW ALERT WHEN USERID IS WRONG
                        let alert = UIAlertController(title:"", message:result , preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                            
                            //MOVE TO HOME SCREEN ON SUCCESS
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
