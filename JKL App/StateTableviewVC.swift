//
//  StateTableviewVC.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 22/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD


//PROTOCOL.
protocol StateProtocol
{
    func EDITPstateName(valueSent: String)
    
}

//ID PROTOCOL.
protocol StateIDProtocol
{
    func EDITPstateID(valueSent: String)
    
}


class StateTableviewVC: UIViewController, UITableViewDelegate,UITableViewDataSource
{
    //OULETS.
    @IBOutlet var tableview: UITableView!
    
    //VALUES OF TABLEVIEW.
    var states = ["Uttar Pradesh","Haryana","Delhi","Jaipur"]
    
    //DELEAGTE METHOD.
    var Profiledelegate:StateProtocol?
    var stateIdDlegate:StateIDProtocol?
    
    
    //VALUES FOR API.
    var stateID = [String]()
    var stateName = [String]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //NAVIGATION BAR
        self.navigationItem.title = "Select State"
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
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "StatesTableViewCell")
        
        
        //CALL THE STATES API.
        self.stateApi()
        
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
        
        return stateName.count
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "StatesTableViewCell")
        
        cell.textLabel?.text = self.stateName[indexPath.row]

        
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
        
        //STATE ID
        let stateID = self.stateID[indexPath.row]
        print(stateID)
        stateIdDlegate?.EDITPstateID(valueSent: stateID)
        UserDefaults.standard.set(stateID, forKey: "stateID")
        UserDefaults.standard.synchronize()
        
        //STATE NAME
        Profiledelegate?.EDITPstateName(valueSent: str)
        
        
       self.navigationController?.popViewController(animated: true)
        
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
    
    //STATE API.
    func stateApi()
    {
        let user = "lakshya"
        let password = "lakshya@001"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }

        
        
        let postString = "http://jklsky.com/api/Service.svc/GetStateMaster"
        
      
        
        Alamofire.request(postString, method: .post, parameters: nil,
                          
                          encoding: JSONEncoding.default, headers:headers)
            
     .responseJSON { response in
     
        self.showProgress()
                
                if((response.result.value) != nil)
                {
                    self.hideProgress()
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    
                    
                    let result = swiftyJsonVar["GetStateMaster"]["Result"].stringValue
                    print(result)
                    
                    
                    for response in swiftyJsonVar["GetStateMaster"]["Response"].arrayValue
                    {
                      
                        //STATE ID
                        let stateid = response["StateId"].stringValue
                        self.stateID.append(stateid)
                        print(self.stateID)
                        
                        //STATE NAME
                        let stateName = response["StateName"].stringValue
                        self.stateName.append(stateName)
                        print(self.stateName)
                        

                    }
                    
                    if swiftyJsonVar["GetStateMaster"]["Result"].stringValue == "Success"
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
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                    
                }
                
                
        }
        
        
    }


  
}
