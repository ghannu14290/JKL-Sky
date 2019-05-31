//
//  DistrictVC.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 26/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD


//PROTOCOL.
protocol DistrictProtocol
{
    func EDITPdistrictName(valueSent: String)
    
}


//ID PROTOCOL.
protocol DistrictIDProtocol
{
    func EDITPdistrictID(valueSent: String)
    
}

class DistrictVC: UIViewController, UITableViewDelegate,UITableViewDataSource
{

    //OUTLET
    @IBOutlet var tablevieqw: UITableView!
    
    
    //VALUE OF STATEID FROM PREVIOUS VIEW CONTROLLER.
    var id : String!
    
    
    //VALUES FOR API.
    var districtId = [String]()
    var districtName = [String]()
    
    
    //DELEAGTE METHOD.
    var districtdelegate:DistrictProtocol?
    var districtIDdelegate:DistrictIDProtocol?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        print("ID is \(id)")
        //NAVIGATION BAR
        self.navigationItem.title = "Select District"
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 32/255, green: 95/255, blue: 166/255, alpha: 1)
        
        
        
        //BACKBUTTON ON NAVIGATION BAR.
        let backButn: UIButton = UIButton()
        backButn.setImage(UIImage(named: "ic_action_back (1)"), for: .normal)
        backButn.frame = CGRect(x: 0,y: 0,width: 30,height: 30)
        backButn.addTarget(self, action: #selector(back), for:.touchUpInside)
        backButn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20.0, bottom: 0, right: 13.0)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: backButn), animated: true)
        
        
        
        //TABLEVIEW
        tablevieqw.delegate      =   self
        tablevieqw.dataSource    =   self
        tablevieqw.register(UITableViewCell.self, forCellReuseIdentifier: "DistrictTableViewCell")
        
        
        if id  == nil
        {
            print("Alert")
            
            //SHOW ALERT WHEN STATE ID IS NIL
            let alert = UIAlertController(title:"", message:"No data available, please choose State first" , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                
                self.back()
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            //CALL THE STATES API.
            self.districtApi()
        }
        
        
        
        
        
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
    
    //TABLEVIEW DELEGATE AND DATASOURCE METHODS.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return districtName.count
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "DistrictTableViewCell")
        
        cell.textLabel?.text = self.districtName[indexPath.row]
        
        
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
        
        //DISTRICT ID
        let districtID = self.districtId[indexPath.row]
        print(districtID)
        districtIDdelegate?.EDITPdistrictID(valueSent: districtID)
        UserDefaults.standard.set(districtID, forKey: "districtID")
        UserDefaults.standard.synchronize()
        
        //DISTRICT NAME
        districtdelegate?.EDITPdistrictName(valueSent: str)
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
    
    //DISTRICT API.
    func districtApi()
    {
        
        
        let user = "lakshya"
        let password = "lakshya@001"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }

        let postString = Common.BaseUrl + "GetDistrictMaster"
        
        
        let newTodo: [String: Any] =
                [
                "StateId":id!
                ] as [String : Any]
        
        Alamofire.request(postString, method: .post, parameters: newTodo,
                          
                          encoding: JSONEncoding.default, headers:headers)
            
            .responseJSON { response in
                
                self.showProgress()
                
                if((response.result.value) != nil)
                {
                    self.hideProgress()
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    
                    
                    let result = swiftyJsonVar["GetDistrictMaster"]["Result"].stringValue
                    print(result)
                    
                    
                    for response in swiftyJsonVar["GetDistrictMaster"]["Response"].arrayValue
                    {
                        
                        //District ID
                        let districtid = response["DistrictId"].stringValue
                        self.districtId.append(districtid)
                        print(self.districtId)
                        
                        //DISTRICT NAME
                        let districtName = response["DistrictName"].stringValue
                        self.districtName.append(districtName)
                        print(self.districtName)
                        
                        
                    }
                    
                    if swiftyJsonVar["GetDistrictMaster"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                        self.tablevieqw.reloadData()
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
