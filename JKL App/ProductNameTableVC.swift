//
//  ProductNameTableVC.swift
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
protocol productProtocolo
{
    func productname(valueSent: String)
    
}


class ProductNameTableVC: UIViewController, UITableViewDelegate,UITableViewDataSource
{
    //OUTLETS
    @IBOutlet var tableview: UITableView!
    
    //VALUES FOR API.
    var productID =  [String]()
    var productName = [String]()
    
    
    //DELEAGTE METHOD.
    var productNameDelegate:productProtocolo?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //CALL API FUNCTION.
        self.ProductApi()
    
        
        //NAVIGATION BAR
        self.navigationItem.title = "Select Product"
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
        
        
        
        //TABLEVIEW
        tableview.delegate      =   self
        tableview.dataSource    =   self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "ProductnameTableViewCell")
        
        
}

    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //TABLEVIEW DELEGATE AND DATASOURCE METHODS.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return productName.count
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "ProductnameTableViewCell")
        
       
        cell.textLabel?.text = self.productName[indexPath.row]
        
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
        
        //PRODUCT ID
        let productID = self.productID[indexPath.row]
        print(productID)
        UserDefaults.standard.set(productID, forKey: "productID")
        UserDefaults.standard.synchronize()
        
        //PRODUCT NAME
        productNameDelegate?.productname(valueSent: str)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //PRODUCT API.
    func ProductApi()
    {
        
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        let newTodo: [String: Any] =  ["UserId": userID] as [String : Any]
        
        print(newTodo)

        let user = "lakshya"
        let password = "lakshya@001"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }

        let postString = Common.BaseUrl + "GetProductMaster"
        
        
        
        Alamofire.request(postString, method: .post, parameters: newTodo,
                          
                          encoding: JSONEncoding.default, headers:headers)
            
            .responseJSON { response in
                
                self.showProgress()
                
                if((response.result.value) != nil)
                {
                    self.hideProgress()
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    
                    
                    let result = swiftyJsonVar["GetProductMaster"]["Result"].stringValue
                    print(result)
                    
                    
                    for response in swiftyJsonVar["GetProductMaster"]["Response"].arrayValue
                    {
                        
                        //PRODUCT ID
                        let productID = response["ProductId"].stringValue
                        self.productID.append(productID)
                        print(self.productID)
                        
                        
                        //PRODUCT NAME
                        let productName = response["ProductName"].stringValue
                        self.productName.append(productName)
                        print(self.productName)
                        
                        
                    }
                    
                    if swiftyJsonVar["GetProductMaster"]["Result"].stringValue == "Success"
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
