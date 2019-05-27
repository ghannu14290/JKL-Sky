//
//  CampaignTypeVc.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 09/09/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD


//ID PROTOCOL.
protocol MyCampaignProtocol
{
    func campaignId(valueSent: String)
    
}

//NAME PROTOCOL.
protocol campNameProtocol
{
    func campaihName(valueSent: String)
    
}

class CampaignTypeVc: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    //OUTLETS.
    @IBOutlet var tableview: UITableView!
    
    //OUTLETS FOR API.
    var campaignID = [String]()
    var campaignName = [String]()
    
    //DELEAGTE METHOD.
    var campIdDelegate:MyCampaignProtocol?
    var campnameDelegate:campNameProtocol?
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //NAVIGATION BAR
        self.navigationItem.title = "Select Campaign Type"
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 32/255, green: 95/255, blue: 166/255, alpha: 1)
        
        
        
        //BACKBUTTON ON NAVIGATION BAR.
        let backButn: UIButton = UIButton()
        backButn.setImage(UIImage(named: "ic_action_back (1)"), for: .normal)
        backButn.frame = CGRect(x: 0,y: 0,width: 30,height: 30)
        backButn.addTarget(self, action: #selector(back), for:.touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: backButn), animated: true)
      
        
        //TABLEVIEW
        tableview.delegate      =   self
        tableview.dataSource    =   self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "CampaignTypeTableViewCell")
        
         //CALL THE API.
        self.campaignTypeApi()
        
    }
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //TABLEVIEW DELEGATE AND DATASOURCE METHODS.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if campaignName.count == 0
        {
            let alert = UIAlertController(title:"", message:"Coming Soon!!" , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                
               self.navigationController?.popViewController(animated: true)
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
        return campaignName.count
        }
        
         return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "StatesTableViewCell")
        
        cell.textLabel?.text = self.campaignName[indexPath.row]
        
        
        cell.backgroundView = UIImageView(image: UIImage(named: "ios_block_new"))
        cell.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        print(cell)
        let str: String = (cell.textLabel?.text)!
        print(str)
        
        //CAMPAIGN ID
        let campid = self.campaignID[indexPath.row]
        print(campid)
        campIdDelegate?.campaignId(valueSent: campid)
        
        //CAMPAIGN NAME
        campnameDelegate?.campaihName(valueSent: str)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

    //CAMPAIGN TYPE API
    func campaignTypeApi()
    {
        //MEMBER NAME
        let userId = UserDefaults.standard.object(forKey:"userID") as! String
        print(userId)
        
        
        let postString = "http://jklsky.com/api/Service.svc/GetStoreAdvertisingCampaign"
        
        let newTodo: [String: Any] = ["UserId":userId] as [String : Any]
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
                    
                    
                    let result = swiftyJsonVar["GetStoreAdvertisingCampaign"]["Result"].stringValue
                    print(result)
                    
                    
                    for response in swiftyJsonVar["GetStoreAdvertisingCampaign"]["Response"].arrayValue
                    {
                        
                        //CAMPAIGN ID
                        let campId = response["CampaignID"].stringValue
                        self.campaignID.append(campId)
                        print(self.campaignID)
                        
                        //CAMPAIGN NAME
                        let campname = response["CampaignName"].stringValue
                        self.campaignName.append(campname)
                        print(self.campaignName)
                       
                    }
                    
                    if swiftyJsonVar["GetStoreAdvertisingCampaign"]["Result"].stringValue == "Success"
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
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
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
