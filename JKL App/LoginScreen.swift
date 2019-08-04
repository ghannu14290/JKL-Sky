//
//  LoginScreen.swift
//  JKL SKY APP
//
//  Created by Ramandeep Singh Bakshi on 16/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD


@available(iOS 10.0, *)
class LoginScreen: UIViewController, UITextFieldDelegate, UIWebViewDelegate
{
    //LOGIN OUTLETS..
    @IBOutlet var loginIdTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var forgotPasswordLabel: UILabel!
    
    //FORGOT PASSWORD OUTLETS
    @IBOutlet var forgotPopUpView: UIView!
    @IBOutlet var userIDTextfield: UITextField!
    @IBOutlet var cancelView: UIButton!
    @IBOutlet var submitview: UIButton!
    @IBOutlet var alertPopoupView: UIView!
    
    //UIVIEW.
    let backView:UIWebView = UIWebView(frame: CGRect(x: 18, y: 36, width: 284, height:506))
    
    //WEBVIEW.
    let myWebView:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: 284, height:460))
    
    //BOOL VALUE FOR ACCEPT AND  DECLINE THE T&C.
    var valueTC:Bool! = false
    
    //FOR LOGIN API.
    var error_code : Int = 0
    var loginArray = NSArray()
    var Response = NSArray()
    var result = String()
    var userId = String()
    var mobile_no = String()
    var profile_image = String()
    var member_type = String()
    var member_name = String()
    var guID = String()
    var tierlevel = String()
    var balance = String()
    
    //FOR FORGOT PWD API.
    var frgterror_code : Int = 0
    var frgtresult = String()
   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //CALL GESTURE FUNC FOR USING THE TAP FUNCTION.
          self.gestureFunctions()
        
        //SET THE BORDER COLOR AND MAKE THE BORDER ROUNDED-RECT OF FORGOT PSSWRD POPUP VIEW.
         forgotPopUpView.layer.borderColor = UIColor.lightGray.cgColor
         forgotPopUpView.layer.borderWidth = 0.5;
         forgotPopUpView.layer.cornerRadius = 5.0;
        
        //CALL THE DELEGATE FUNC OF TEXTFIELD
         self.loginIdTextfield.delegate = self
         self.passwordTextfield.delegate = self
         self.userIDTextfield.delegate = self
    }
    
    //GESTURE FUNCTIONs
    func gestureFunctions()
    {
       //TAP ON FORGOT LABEL.
         let Frgttap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openForgotView))
        forgotPasswordLabel.addGestureRecognizer(Frgttap)
        
      //TAP ON VIEW.
        let tapVIEW: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapVIEW)
        
    }

    //OPEN FORGOT VIEW WHEN USER TAPPED ON FORGOT PASSWORD.(GESTURE RECOGNIZER)
    @objc func openForgotView()
    {
        //UNHIDE THE FORGOT POPUP VIEW WHEN USER CLICKED ON FORGOT PASSWORD.
         self.forgotPopUpView.isHidden = false
    }
    
    //DISMISS KEYBOARD.
    @objc func dismissKeyboard()
    {
        loginIdTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        userIDTextfield.resignFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //HIDE NAVIGATION BAR.
          self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //HIDE FORGOTVIEW WHEN VIEW APPEARED.
          self.forgotPopUpView.isHidden = true
        
        //HIDE ALERTVIEW WHEN VIEW APPEARED
         self.alertPopoupView.isHidden = true
        
    }
    
    //SUBMIT BUTTON ACTION.
    @IBAction func submitButtonAction(_ sender: Any)
    {
        //CHECK THE VALIDATION AND MOVE TO HOME SCREEN.
          if areValidTextfields()
          {
            LoginApi()
        
          }
        
        //HIDE KEYBOARD.
        userIDTextfield.resignFirstResponder();
        passwordTextfield.resignFirstResponder();
    }
    
    //DELEGATE METHODS OF WEBVIEW
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        self.showProgress()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        self.hideProgress()
    }
    
    //WEBVIEW BUTTON ACTION FUNCTIONS
    @objc func declineT_C()
    {
       self.backView.removeFromSuperview()
        
        //SHOW ALERT
        let alert = UIAlertController(title:"", message:"You must accept the Terms and Conditions to proceed." , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func acceptT_C()
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! HomeScreen
        self.navigationController?.pushViewController(secondViewController, animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
    }
    
    //CANCEL BUTTON ACTION (FORGOT PASSWORD).
    @IBAction func canclActionButton(_ sender: Any)
    {
        //CHANGE THE BUTTON TEXT COLOR.
          self.cancelView.titleLabel?.tintColor = UIColor.blue
        
        //HIDE THE FoRGoTPOPUP VIEW.
         self.forgotPopUpView.isHidden = true
    }
    
    //SUBMIT BUTTON ACTION (FORGOT PASSWORD).
    @IBAction func forgotSbmitAction(_ sender: Any)
    {
         //HIDE THE  FoRGoTPOPUP VIEW.
            self.forgotPopUpView.isHidden = true
            self.forgotPwdApi()
      
    }

    //OK ALERT BUTTON ACTION (FORGOT PASSWORD).
    @IBAction func okAlertButnAction(_ sender: Any)
    {
        //HIDE THE ALERT VIEW.
        self.alertPopoupView.isHidden = true
        
    }
    
    //VALIDATION ON TEXTFIELDS of LOGIN
    func areValidTextfields() -> Bool
    {
        if loginIdTextfield.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter the Login ID!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
       else if passwordTextfield.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter the Password!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
        
    }
    
    
    //VALIDATION ON TEXTFIELD OF FORGOT PWD
    func areValidUserIDTf() -> Bool
    {
        if userIDTextfield.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter the User ID!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
    
        return true
        
    }

    

    //TEXTFIELD DELEGATE METHODS
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        userIDTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        loginIdTextfield.resignFirstResponder()
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
        userIDTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        loginIdTextfield.resignFirstResponder()
        
        return true;
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //LOGIN API.
    
    func LoginApi()
    {
            let deviceID = UIDevice.current.identifierForVendor!.uuidString

        print("deviceID is  \(deviceID)")
        let user = "lakshya"
        let password = "lakshya@001"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }

        let postString = Common.BaseUrl + "Login"
        
        let newTodo: [String: Any] =
            [
                "UserId": loginIdTextfield.text!,
                "Password":passwordTextfield.text!,
                "DeviceId":deviceID,
                "LoginType":""

                ] as [String : Any]
        
        self.showProgress()
        Alamofire.request(postString, method: .post, parameters: newTodo,
                          
                          encoding: JSONEncoding.default, headers : headers)
            
            .responseJSON { response in
                if((response.result.value) != nil)
                {
                    self.hideProgress()
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    
                    self.error_code = swiftyJsonVar["Login"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                    let result = swiftyJsonVar["Login"]["Result"].stringValue
                    print(result)
                    
                    self.Response = swiftyJsonVar["Login"]["Response"].arrayValue as NSArray
                    print(self.Response)
                    for response in swiftyJsonVar["Login"]["Response"].arrayValue
                    {
                        //USERID
                        let userID = response["UserId"].stringValue
                        self.userId.append(userID)
                        print(self.userId)
                        //SAVE THE USERID IN USERDEFAULT.
                        UserDefaults.standard.set(userID, forKey: "userID")
                        UserDefaults.standard.synchronize()
                        
                        //MOBILE NUMBER
                        let mobileNum = response["RegisteredMobileNo"].stringValue
                        self.mobile_no.append(mobileNum)
                        print(self.mobile_no)
                        //SAVE THE MOBILE NUMBER IN USERDEFAULT.
                        UserDefaults.standard.set(mobileNum, forKey: "mobileNum")
                        UserDefaults.standard.synchronize()
                        
                        
                        //PROFILE IMAGE
                        let profileImage = response["ProfileImage"].stringValue
                        self.profile_image.append(profileImage)
                        print(self.profile_image)
                        //SAVE THE PROFILE IMAGE IN USERDEFAULT.
                        UserDefaults.standard.set(profileImage, forKey: "ProfileImage")
                        UserDefaults.standard.synchronize()
                        
                        
                        //MEMBER TYPE 
                        let memberType = response["MemberType"].stringValue
                        self.member_type.append(memberType)
                        print(self.member_type)
                        //SAVE THE MEMBER TYPE IN USERDEFAULT.
                        UserDefaults.standard.set(memberType, forKey: "memberType")
                        UserDefaults.standard.synchronize()
                        

                        //MEMBER NAME
                        let memberName = response["MemberName"].stringValue
                        self.member_name.append(memberName)
                        print(self.member_name)
                        //SAVE THE MEMBER NAME IN USERDEFAULT.
                        UserDefaults.standard.set(memberName, forKey: "memberName")
                        UserDefaults.standard.synchronize()
                        
                        
                        //GUID
                        let guid = response["Guid"].stringValue
                        self.guID.append(guid)
                        print(self.guID)
                        //SAVE THE GUID IN USERDEFAULT.
                        UserDefaults.standard.set(guid, forKey: "guid")
                        UserDefaults.standard.synchronize()
                        
                        
                        //TIER LEVEL.
                        let level = response["TierName"].stringValue
                        self.tierlevel.append(level)
                        print(self.tierlevel)
                        //SAVE THE tierlevel IN USERDEFAULT.
                        UserDefaults.standard.set(level, forKey: "level")
                        UserDefaults.standard.synchronize()
                        
                        //BALANCE.
                        let blnc = response["Balance"].stringValue
                        self.balance.append(blnc)
                        print(self.tierlevel)
                        //SAVE THE tierlevel IN USERDEFAULT.
                        UserDefaults.standard.set(blnc, forKey: "blnc")
                        UserDefaults.standard.synchronize()
                    }
                    
                        if swiftyJsonVar["Login"]["Result"].stringValue == "Success"
                        {
                            print ("Success")
                            self.hideProgress()
                            //MOVE TO HOME SCREEN ON SUCCESS
                            
                            self.backView.layer.borderColor = UIColor.lightGray.cgColor
                            self.backView.layer.borderWidth = 1.0;
                            self.backView.layer.cornerRadius = 5.0;
                            
                            print("Login Successfull!!");
                            //HIDE THE POPUP VIEW FIRST THEN SHOW THE ALERT VIEW.
                            self.forgotPopUpView.isHidden = true
                            self.alertPopoupView.isHidden = true
                            self.view.addSubview(self.backView)
                            self.backView.addSubview(self.myWebView)
                            self.myWebView.delegate = self
                            
                            if let cookies = HTTPCookieStorage.shared.cookies {
                                for cookie in cookies {
                                    NSLog("\(cookie)")
                                }
                            }
                            
                            let storage = HTTPCookieStorage.shared
                            for cookie in storage.cookies! {
                                storage.deleteCookie(cookie)
                            }
                            
                            
                            URLCache.shared.removeAllCachedResponses()
                            URLCache.shared.diskCapacity = 0
                            URLCache.shared.memoryCapacity = 0
                            
                            let url = NSURL (string: "http://jklsky.com/MobileApp/termandCondition.htm");
                            let requestObj = NSURLRequest(url: url! as URL)
                            self.myWebView.loadRequest(requestObj as URLRequest);
                            //DECLINE BUTTON
                            let declineButton   = UIButton(type: UIButtonType.custom) as UIButton
                            declineButton.frame = CGRect(x:12, y:470, width: 119, height: 30)
                            declineButton.backgroundColor = UIColor.blue
                            declineButton.setTitle("Decline", for: .normal)
                            declineButton.setTitleColor(UIColor.white, for: .normal)
                            declineButton.addTarget(self, action: #selector(self.declineT_C), for: UIControlEvents.touchUpInside)
                            self.backView.addSubview(declineButton)
                            //ACCEPT BUTTON
                            let acceptButton  = UIButton(type: UIButtonType.custom) as UIButton
                            acceptButton.frame = CGRect(x:150, y:470, width: 119, height: 30)
                            acceptButton.backgroundColor =  UIColor(red: 37/255, green: 155/255, blue: 36/255, alpha: 1)
                            acceptButton.setTitle("Accept", for: .normal)
                            acceptButton.setTitleColor(UIColor.white, for: .normal)
                            acceptButton.addTarget(self, action: #selector(self.acceptT_C), for: UIControlEvents.touchUpInside)
                            self.backView.addSubview(acceptButton)
                        }
                       
                        else
                        {
                            self.hideProgress()
                            
                            //SHOW ALERT WHEN USERID OR PASSWORD IS WRONG
                            let alert = UIAlertController(title:"", message:result , preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                                
                                self.hideProgress()
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                }
                
            }
    }
    
    
    //FORGOT PASSWORD API.
    
    func forgotPwdApi()
    {
        
        let postString = Common.BaseUrl + "ForgotPassword"
        
        let newTodo: [String: Any] =
                ["UserId": userIDTextfield.text!] as [String : Any]
       
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
                    
                    self.frgterror_code = swiftyJsonVar["ForgotPassword"]["ErrorCode"].intValue
                    print(self.frgterror_code)
                    
                    let result = swiftyJsonVar["ForgotPassword"]["Result"].stringValue
                    print(self.frgtresult)
                    
                    
                
                if swiftyJsonVar["ForgotPassword"]["Result"] == "Password has been sent on your registered mobile number"
                {
                    print ("Success")
                    
                    //SHOW THE SUCCESS ALERTVIEW.
                    self.alertPopoupView.isHidden = false
                    
                }
                else
                {
                    self.hideProgress()
                    //SHOW ALERT WHEN USERID OR PASSWORD IS WRONG
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






class Common: NSObject {
   //static let BaseUrl = "http://jklakshmidemo.netcarrots.in/api/Service.svc/"
   static let BaseUrl = "http://jklsky.com/api/Service.svc/"

}
