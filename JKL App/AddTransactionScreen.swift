//
//  AddTransactionScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 18/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import QuartzCore
import Alamofire
import SwiftyJSON
import MBProgressHUD
import DatePickerDialog


class AddTransactionScreen: UIViewController, UITextFieldDelegate, productProtocolo, SiteTypeProtocolo
{
    
    //OUTLETS.
    
    @IBOutlet var memberNamelabel: UILabel!
    @IBOutlet var memberTypeLabel: UILabel!
    @IBOutlet var mobileNOLabel: UILabel!
    @IBOutlet var balnceLabel: UILabel!
    @IBOutlet var submitbtn: UIButton!
    @IBOutlet var noOfBagsTextfield: UITextField!
    @IBOutlet var productPlchldrLabel: UILabel!
    @IBOutlet var siteTypeplchldrLabel: UILabel!
    @IBOutlet var siteTypebtn: UIButton!
    @IBOutlet var productNameBtn: UIButton!
    @IBOutlet var dateBtn: UIButton!
    @IBOutlet var dateplchldr: UILabel!
    
    //VALUES FROM PREVIOUS VIEW CONTROLLER.
    var memberUserId = String()
    var membermobileNumber = String()
    var memberName = String()
    var memberType = String()
    var balance = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        //NAVIGATION BAR.
        self.navigationItem.title = "Add Transaction"
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
        
        //DISPLAY DETAILS OF THE MEMBER.
        self.displayDetails()
        
        
        //CALL THE TEXTFIELD DELEGATE.
        noOfBagsTextfield.delegate = self
        
        
        //CALL GESTURE FUNC FOR USING THE TAP FUNCTION.
        self.gestureFunctions()
        
        
        //CALL THE FUNCTION FOR SETTING THE BUTTON'S BORDER COLOR
        self.chnageBorder()
        
    }
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
        if membertype == "D"
        {
            self.navigationController?.popViewController(animated: true)
            
        }
        else if membertype == "R"
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.leftmenu()
            
        }
        
        
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //DISPLAY DETAILS OF THE MEMBER.
    func displayDetails()
    {
        let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
        if membertype == "D"
        {
            memberNamelabel.text = memberName
            memberTypeLabel.text = "Member Type : \(memberType)"
            mobileNOLabel.text = membermobileNumber
            balnceLabel.text = "Balance : \(balance)"
            
        }
        else if membertype == "R"
        {
            
            //MEMBER NAME
            let username = UserDefaults.standard.object(forKey:"memberName") as! String
            print(username)
            memberNamelabel.text =  username
            
            //MEMBER TYPE 
            memberTypeLabel.text = "Member Type : Retailer"
            
            //MOBILE NUMBER
            let mobileNumber = UserDefaults.standard.object(forKey:"mobileNum") as! String
            print(mobileNumber)
            mobileNOLabel.text = mobileNumber
            
            //BALANCE
            let balancee = UserDefaults.standard.object(forKey:"blnc") as! String
            print(balancee)
            balnceLabel.text = "Balance : \(balancee)"
            
        }
      
    }
    
    
    @IBAction func dateAction(_ sender: Any)
    {
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) { (date) in
            if let dt = date {
                print("\(dt)")
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "dd-MMM-yyyy" //Your New Date format as per requirement change it own
                let newDate = dateFormatter.string(from: date!) //pass Date here
                //print(newDate) //New formatted Date string
                self.dateBtn.setTitle(newDate, for: .normal)
                self.dateplchldr.isHidden = true
            }
        }

        
    }
    
    
    //FUNCTION FOR SET THE BORDER OF BUTTON AND ITS COLOR.
    func chnageBorder()
    {
        //PRODUCT NAME BUTTON.
        productNameBtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        productNameBtn.layer.borderWidth = 0.5;
        productNameBtn.layer.cornerRadius = 5.0;
        
        
        //SITE TYPE BUTTON.
        siteTypebtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        siteTypebtn.layer.borderWidth = 0.5;
        siteTypebtn.layer.cornerRadius = 5.0;
        
        
        //DATE BUTTON.
        dateBtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        dateBtn.layer.borderWidth = 0.5;
        dateBtn.layer.cornerRadius = 5.0;
    }
    
    //VALIDATIONS .
    func areValidTextfields() -> Bool
    {
        if productNameBtn.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select Product Name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
//        if siteTypebtn.titleLabel?.text == nil
//        {
//            let alert = UIAlertController(title: "", message: "Please select Type of Site", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            return false
//        }
        
        if dateBtn.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select purchase date", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if noOfBagsTextfield.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter number of bags", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        
        return true
        
    }
    
    
    
    //PROTOCOL DELEGATE METHOD.
    func productname(valueSent: String)
    {
        productPlchldrLabel.isHidden = true
        productNameBtn.setTitle(valueSent, for: .normal)
        
    }
    
    func siteType(valueSent: String)
    {
        siteTypeplchldrLabel.isHidden = true
        siteTypebtn.setTitle(valueSent, for: .normal)
        
    }
    
    @IBAction func submitbtn(_ sender: Any)
    {
        
        if areValidTextfields()
        {
            let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
            print(membertype)
            
            if membertype == "D"
            {
                self.addTransactionDelaer()
                
            }
            else if membertype == "R"
            {
               self.addTransactionReatiler()
                
            }
            

        }
        
        
    }
    
    @IBAction func sityeTypeBtn(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SiteTypeVC") as! SiteTypeVC
        secondViewController.siteTypeDelegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        noOfBagsTextfield.resignFirstResponder()
    }
    
    @IBAction func productNameBtn(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductNameTableVC") as! ProductNameTableVC
        secondViewController.productNameDelegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        noOfBagsTextfield.resignFirstResponder()
        
    }

    //GESTURE FUNCTIONs
    func gestureFunctions()
    {
        //TAP ON VIEW.
        let tapVIEW: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapVIEW)
        
    }
    
    //DISMISS KEYBOARD.
    @objc func dismissKeyboard()
    {
        noOfBagsTextfield.resignFirstResponder()
    }
    

    //TEXTFIELD DELEGATE METHODS
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
       
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        noOfBagsTextfield.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        noOfBagsTextfield.resignFirstResponder()
        return true;
    }

    
    //ADD TRANSACTION API
    func addTransactionReatiler()
    {
        self.showProgress()
       
        //MEMBER NAME
        let userId = UserDefaults.standard.object(forKey:"userID") as! String
        print(userId)
     
        //MOBILE NUMBER
        let mobileNumber = UserDefaults.standard.object(forKey:"mobileNum") as! String
        print(mobileNumber)
        
        //PRODUCT ID IN USERDEFAULT.
        let productid = UserDefaults.standard.object(forKey:"productID") as! String
        print(productid)
        
        //SITE TYPE ID IN USERDEFAULT.
        let sitetypeID = UserDefaults.standard.object(forKey:"sitetypeid") as! String
        print(sitetypeID)
        
        let string = dateBtn.titleLabel?.text
        
        let postString = "http://jklakshmidemo.netcarrots.in/API/Service.svc/AddTransaction"
        
        let newTodo: [String: Any] =
                                    ["UserId":userId,
                                    "UserId_MobileNumber":mobileNOLabel.text!,
                                    "ProductName":productid,
                                    "NoOfBag":noOfBagsTextfield.text!,
                                    "SiteType":sitetypeID,
                                    "PurchaseDate":string!] as [String : Any]
        
        print(newTodo)
        
        Alamofire.request(postString, method: .post, parameters: newTodo,
                          
                          encoding: JSONEncoding.default)
            
            .responseJSON { response in
                
                
                if((response.result.value) != nil)
                {
                    self.hideProgress()
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                   
                    let result = swiftyJsonVar["AddTransaction"]["Result"].stringValue
                    print(result)
                    
                    
                    if swiftyJsonVar["AddTransaction"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
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
                        
                    else
                    {
                        self.hideProgress()
                        //SHOW ALERT WHEN USERID IS WRONG
                        let alert = UIAlertController(title:"", message:result , preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
    
                    }
    
    
    
                }
    
    
    }
    
    
}
    
    func addTransactionDelaer()
    {
        self.showProgress()
        
        //MEMBER ID
        let useriD = UserDefaults.standard.object(forKey:"userID") as! String
        print(useriD)
        
        
        //MOBILE NUMBER
        let mobileNumber = UserDefaults.standard.object(forKey:"mobileNum") as! String
        print(mobileNumber)
        
        //PRODUCT ID IN USERDEFAULT.
        let productid = UserDefaults.standard.object(forKey:"productID") as! String
        print(productid)
        
        //SITE TYPE ID IN USERDEFAULT.
        let sitetypeID = UserDefaults.standard.object(forKey:"sitetypeid") as! String
        print(sitetypeID)
        
        
        let string = dateBtn.titleLabel?.text
        
        let postString = Common.BaseUrl + "AddTransaction"
        
        let newTodo: [String: Any] =
            ["UserId": useriD,
             "UserId_MobileNumber":mobileNOLabel.text!,
             "ProductName":productid,
             "NoOfBag": noOfBagsTextfield.text!,
             "SiteType":sitetypeID,
             "PurchaseDate":string!] as [String : Any]
        
        print(newTodo)
        
        
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
                    
                    let result = swiftyJsonVar["AddTransaction"]["Result"].stringValue
                    print(result)
                    
                    
                    if swiftyJsonVar["AddTransaction"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
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
                        
                    else
                    {
                        self.hideProgress()
                        //SHOW ALERT WHEN USERID IS WRONG
                        let alert = UIAlertController(title:"", message:result , preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        self.hideProgress()

                        
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
