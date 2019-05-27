//
//  changePasswordScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 18/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD



class changePasswordScreen: UIViewController,UITextFieldDelegate
{
    //OULETS.
    @IBOutlet var oldPasswrdTextfield: UITextField!
    @IBOutlet var newPasswordTextfield: UITextField!
    @IBOutlet var reEnterNewpwdTextfield: UITextField!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()

        self.navigationItem.title = "Change Password"
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
        
        
        //TETXFIELD DELEGATE.
        oldPasswrdTextfield.delegate = self
        newPasswordTextfield.delegate = self
        reEnterNewpwdTextfield.delegate = self
    }
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR.
    @objc func back()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
    }

    
    //CANCEL BUTTON ACTION.
    @IBAction func cancelButton(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
    }
    
    
    //SUBMIT BUTTON ACTION.
    @IBAction func submitButtonAction(_ sender: Any)
    {
        
        if areValidTextfields()
        {
            self.changePasswordApi()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //VALIDATION ON TEXTFIELDS.
    func areValidTextfields() -> Bool
    {
        if oldPasswrdTextfield.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter the old password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                self.hideProgress()
                
            }))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if newPasswordTextfield.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter the new password!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                //run your function here
                self.hideProgress()
                
            }))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if reEnterNewpwdTextfield.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please re-enter the new password!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                //run your function here
                self.hideProgress()
                
            }))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if newPasswordTextfield.text != reEnterNewpwdTextfield.text
        {
            let alert = UIAlertController(title: "", message: "Re-entered password is not same as new password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                //run your function here
                self.hideProgress()
                
            }))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        
        return true
        
    }
    
    
//CHANGE PASSWORD API.
    
    func changePasswordApi()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        
        let postString = "http://jklsky.com/api/Service.svc/ChangePassword"
        
        let newTodo: [String: Any] =
            [
             "UserId": userID,
             "OldPassword" : oldPasswrdTextfield.text!,
             "NewPassword": newPasswordTextfield.text!,
             "ConfirmPassword": reEnterNewpwdTextfield.text!
            ] as [String : Any]
        
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
                    
                    
                    
                    
                    if swiftyJsonVar["ChangePassword"]["Result"].stringValue == "SUCCESS"
                    {
                        print ("Success")
                        
                        self.hideProgress()
                        
                        let alert = UIAlertController(title: "Success", message: "Password Changed Successfully", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                            
                            //MOVE TO HOME SCREEN WHEN USER CLICK ON OK BUTTON.
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.leftmenu()
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }
                        
                    else
                    {
                        
                        
                    let alert = UIAlertController(title:"", message:swiftyJsonVar["ChangePassword"]["Result"].stringValue , preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                            
                            self.hideProgress()
                            
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

    
    //TEXTFIELD DELEGATE METHODS
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        oldPasswrdTextfield.resignFirstResponder()
        newPasswordTextfield.resignFirstResponder()
        reEnterNewpwdTextfield.resignFirstResponder()
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
        oldPasswrdTextfield.resignFirstResponder()
        newPasswordTextfield.resignFirstResponder()
        reEnterNewpwdTextfield.resignFirstResponder()
        
        return true;
    }

    
}
