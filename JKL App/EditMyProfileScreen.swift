//
//  EditMyProfileScreen.swift
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



class EditMyProfileScreen: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, StateProtocol, DistrictProtocol, StateIDProtocol, DistrictIDProtocol
{
    
    //OUTLETS.
    @IBOutlet var districtplchldrLabel: UILabel!
    @IBOutlet var stateIdLabel: UILabel!
    @IBOutlet var backView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var agencyName: UITextField!
    @IBOutlet var properietrnamr: UITextField!
    @IBOutlet var mobileNumber: UITextField!
    @IBOutlet var pincode: UITextField!
    @IBOutlet var address2: UITextField!
    @IBOutlet var address1: UITextField!
    @IBOutlet var stebtnAction: UIButton!
    @IBOutlet var stateBTn: UIButton!
    @IBOutlet var statePlchldr: UILabel!
    @IBOutlet var userIDTextfield: UITextField!
    @IBOutlet var districtBtn: UIButton!
    
    //VALUES FROM PREVIOUS SCREEN.
    var Editagency_name :String!
    var Editproperieter_name  :String!
    var Editmobile_number :String!
    var Editaddress1  :String!
    var Editaddress2  :String!
    var EditState  :String!
    var EditDistrict  :String!
    var Editpin_code  :String!
    var EditprofileImage :String!
    var EdituserId :String!
    var Idstate : String!
    var IdDistrict : String!
    
    //IMAGEPICKER.
    var imagePicker = UIImagePickerController()
    
    //DELEGATE VALUE.
    var stateValue: String?
    var districtValu: String?
    
    //OUTLETS FOR API.
    var error_code : Int = 0
    var Response = NSArray()
    
    
    
    override func viewDidLoad()
    {
        
        //NAVIGATION BAR
        self.navigationItem.title = "My Profile"
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
        
        
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.borderWidth = 1.0;
        imageView.layer.cornerRadius = 32.0
        imageView.clipsToBounds = true
        
        
        //CALL THE FUNCTION FOR SETTING THE BUTTON'S BORDER COLOR
        self.chnageBorder()
        
        
        //SET DELEGATES FOR TEXTFIELDS.
        agencyName.delegate = self
        properietrnamr.delegate = self
        mobileNumber.delegate = self
        address1.delegate = self
        address2.delegate = self
        pincode.delegate = self
        
        
        //CALL GESTURE FUNC FOR USING THE TAP FUNCTION.
        self.gestureFunctions()
        
        
        //DISPLAY DETAILS.
        self.displayDetails()
        
        //DELEGATE PROTOCOL
        if stateValue == nil
        {
            print("Value from display = \(String(describing: stateValue))")
            stateValue = Idstate
        }
        
        if districtValu == nil
        {
            print("Value from display = \(String(describing: districtValu))")
            districtValu = IdDistrict
        }
        
        
    }
    
  
    
    //DISPLAY DETAILS.
    func displayDetails()
    {
        if EditState == ""
        {
            statePlchldr.isHidden = false
        }
        else
        {
            stateBTn.setTitle(EditState, for: .normal)
            statePlchldr.isHidden = true
        }
        
        if EditDistrict == ""
        {
            districtplchldrLabel.isHidden = false

        }
        else
        {
            districtBtn.setTitle( EditDistrict, for: .normal)
            districtplchldrLabel.isHidden = true
            
        }
        
        districtplchldrLabel.isHidden = true
        statePlchldr.isHidden = true
        userIDTextfield.text = EdituserId
        agencyName.text = Editagency_name
        properietrnamr.text = Editproperieter_name
        mobileNumber.text = Editmobile_number
        address1.text = Editaddress1
        address2.text = Editaddress2
        pincode.text = Editpin_code
        //PROFILE IMAGE.
       imageView.sd_setImage(with: URL(string: EditprofileImage!), placeholderImage: UIImage(named: "if_icons_user_1564534"))
        
        
        
     }
    
    
    //PROTOCOL DELEGATE METHOD.
    func EDITPstateName(valueSent: String)
    {
        statePlchldr.isHidden = true
        stateBTn.setTitle(valueSent, for: .normal)
        
    }
    
    func EDITPdistrictName(valueSent: String)
    {
        districtplchldrLabel.isHidden = true
        districtBtn.setTitle(valueSent, for: .normal)
    }
    
    func EDITPstateID(valueSent: String)
    {
       stateValue = valueSent
    }
    
   func EDITPdistrictID(valueSent: String)
   {
     print(valueSent)
     districtValu = valueSent
   }
    
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //FUNCTION FOR SET THE BORDER OF BUTTON AND ITS COLOR.
    func chnageBorder()
    {
        //STATE  BUTTON.
        stateBTn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        stateBTn.layer.borderWidth = 0.5;
        stateBTn.layer.cornerRadius = 5.0;
        
        //DIStRICT  BUTTON.
        districtBtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        districtBtn.layer.borderWidth = 0.5;
        districtBtn.layer.cornerRadius = 5.0;
    }
    
    //STATE BUTTON
    @IBAction func stateBtn(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "StateTableviewVC") as! StateTableviewVC
        secondViewController.Profiledelegate = self
        secondViewController.stateIdDlegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        agencyName.resignFirstResponder()
        properietrnamr.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        address1.resignFirstResponder()
        address2.resignFirstResponder()
        pincode.resignFirstResponder()
        
    }
    
    @IBAction func district(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DistrictVC") as! DistrictVC
        secondViewController.districtdelegate = self
        secondViewController.districtIDdelegate = self
        secondViewController.id = stateValue
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        agencyName.resignFirstResponder()
        properietrnamr.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        address1.resignFirstResponder()
        address2.resignFirstResponder()
        pincode.resignFirstResponder()
    }
    
    //TEXTFIELD DELEGATE METHODS
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        
        if textField.tag == 1 || textField.tag == 2
        {
            
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y-150, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
        }
            
        else
        {
            print("Other Textfields")
            
        }
        
        
       
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField.tag == 1 || textField.tag == 2
        {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y+150, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
            agencyName.resignFirstResponder()
            properietrnamr.resignFirstResponder()
            mobileNumber.resignFirstResponder()
            address1.resignFirstResponder()
            address2.resignFirstResponder()
            pincode.resignFirstResponder()
        }
        else
        {
            print("Other Textfields")
            agencyName.resignFirstResponder()
            properietrnamr.resignFirstResponder()
            mobileNumber.resignFirstResponder()
            address1.resignFirstResponder()
            address2.resignFirstResponder()
            pincode.resignFirstResponder()
        }
        
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
        
        agencyName.resignFirstResponder()
        properietrnamr.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        address1.resignFirstResponder()
        address2.resignFirstResponder()
        pincode.resignFirstResponder()
        
        return true;
    }
    
    
    @IBAction func submitBtnn(_ sender: Any)
    {
        
        if agencyName.text == Editagency_name &&  properietrnamr.text == Editproperieter_name && mobileNumber.text == Editmobile_number &&  address1.text == Editaddress1 && address2.text == Editaddress2 &&  stateBTn.titleLabel?.text == EditState && districtBtn.titleLabel?.text  == EditDistrict && pincode.text == Editpin_code && imageView.image == UIImage(named: "bg_profile_default")
        {
            
            let alert = UIAlertController(title:"", message:"Do you want exit?" , preferredStyle: UIAlertControllerStyle.alert)
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
            if validMobileNumber()
            {
             self.EditprofileApi()
                
            }
        }
    }
    
    
    //GESTURE FUNCTIONs
    func gestureFunctions()
    {
        //TAP ON VIEW.
        let tapVIEW: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapVIEW)
        
        
        //TAP ON IMAGEVIEW.
        let tapImage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnImageview))
        imageView.addGestureRecognizer(tapImage)
        
        
    }
    
    //DISMISS KEYBOARD.
    @objc func dismissKeyboard()
    {
        agencyName.resignFirstResponder()
        properietrnamr.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        address1.resignFirstResponder()
        address2.resignFirstResponder()
        pincode.resignFirstResponder()
        
    }
    
    
    //OPEN ACTIONSHEET WEN USER TAP ON IMAGEVIEW.
    @objc func tapOnImageview()
    {
      self.actionsheetmemberImage()
    }
    
    
    
    //VALIDATIONS OF TEXTFIELDS.
    
    func areValidTextfields() -> Bool
    {
       
        if agencyName.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter name of the agency", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if properietrnamr.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter your name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if mobileNumber.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter mobile number", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if address1.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter address1", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if address2.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter address2", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if districtBtn.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please enter district", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if stateBTn.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select state", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if pincode.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter address", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        
               return true
        
    }
    
    
    
    //VALID MOBILE NUMBER.
    func validate(value: String) -> Bool
    {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
        
    }
    
    func validMobileNumber() -> Bool
    {
        if validate(value:mobileNumber.text!)
        {
            print("Valid Mobile number")
        }
        else
        {
            let alert = UIAlertController(title: "", message: "Please enter valid mobile number!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        
        if  textField  == mobileNumber {
            let newLength = textField.text!.characters.count + string.characters.count - range.length
            return newLength <= 10
        }else
        {
            return true
            
        }
       
    }
    
    //ACTION SHEET FOR PICK IMAGE.

    func actionsheetmemberImage()
    {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker,animated: true,completion: nil)
        }
        else
        {
            noCamera()
        }
        
        
        
    }
    func noCamera()
    {
        let alertVC = UIAlertController(title: "No Camera",message: "Sorry, this device has no camera",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",style:.default,handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC,animated: true,completion: nil)
    }
    
    
    func photoLibrary()
    {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true,completion: nil)
        
    }
    
    
    //MARK: - DELEGATES OF IMAGEPICKER
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = chosenImage
        imageView.layer.cornerRadius = 32.0;
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        dismiss(animated:true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    

    
    
    //MY PROFILE API.
    func EditprofileApi()
    {
        
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
  
    
        let postString = Common.BaseUrl + "UpdateDealerProfile"
        
        let imageString:String!
        
        if imageView.image == UIImage(named: "if_icons_user_1564534")
        {
            imageString = ""
            
        }
        else
        {
            //BASE64 IMAGE.
            let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)
            print("BASE 64 \(String(describing: imageData))")
            
            imageString = imageData?.base64EncodedString()
            print("image string \(String(describing: imageString))")
        }

        
        let newTodo: [String: Any] =  ["UserId": userID,
                                       "AgencyName": agencyName.text!,
                                       "ProprietorName":properietrnamr.text!,
                                       "MobileNumber":mobileNumber.text!,
                                       "Address1":address1.text!,
                                       "Address2":address2.text!,
                                       "State": stateValue!,
                                       "District": districtValu!,
                                       "Pincode":pincode.text!,
                                       "ImageFileType":"JPEG",
                                       "ProfileImage":imageString!] as [String : Any]
        
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
                    
                    self.error_code = swiftyJsonVar["UpdateDealerProfile"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                    let result = swiftyJsonVar["UpdateDealerProfile"]["Result"].stringValue
                    print(result)
                    
                    
                    if swiftyJsonVar["UpdateDealerProfile"]["Result"].stringValue == "Success"
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
                        
                        //SHOW ALERT WHEN USERID IS WRONG
                        let alert = UIAlertController(title:"", message:result , preferredStyle: UIAlertControllerStyle.alert)
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
   

}
