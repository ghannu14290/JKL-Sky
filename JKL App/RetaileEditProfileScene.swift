//
//  RetaileEditProfileScene.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 26/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//


import UIKit
import QuartzCore
import Alamofire
import SwiftyJSON
import MBProgressHUD
import DatePickerDialog



@available(iOS 10.0, *)
@available(iOS 10.0, *)
@available(iOS 10.0, *)
class RetaileEditProfileScene: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, StateProtocol, DistrictProtocol, StateIDProtocol, DistrictIDProtocol
{
    //OUTLETS.
    @IBOutlet var districtplchldrLabel: UILabel!
    @IBOutlet var stateIdLabel: UILabel!
    @IBOutlet var backView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var agencyName: UITextField!
    @IBOutlet var pincode: UITextField!
    @IBOutlet var address2: UITextField!
    @IBOutlet var address1: UITextField!
    @IBOutlet var stebtnAction: UIButton!
    @IBOutlet var stateBTn: UIButton!
    @IBOutlet var statePlchldr: UILabel!
    @IBOutlet var districtBtn: UIButton!
    @IBOutlet var mobileNumber: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var fisrtName: UITextField!
    
    @IBOutlet weak var dobplaceholder: UILabel!
    @IBOutlet weak var dobBtnn: UIButton!
   
    //VALUES FROM PREVIOUS SCREEN.
    var Editagency_name :String!
    var EditFirstName  :String!
    var EditLastNAme  :String!
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
    var idproof : String!
    @IBOutlet var idproofImageview: UIImageView!
    @IBOutlet var idproofBtn: UIButton!
    
    
    //IMAGEPICKER.
    var imagePicker = UIImagePickerController()
    var imagePicked = 0
    
    
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
        
        //ROUND THE CORNER RADIUS OF IMAGEVIEW.
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.borderWidth = 1.0;
        imageView.layer.cornerRadius = 32.0
        imageView.clipsToBounds = true
        
        
        
        //CALL THE FUNCTION FOR SETTING THE BUTTON'S BORDER COLOR
        self.chnageBorder()
        
        
        //SET DELEGATES FOR TEXTFIELDS.
        agencyName.delegate = self
        fisrtName.delegate = self
        lastName.delegate = self
        address1.delegate = self
        address2.delegate = self
        pincode.delegate = self
        mobileNumber.delegate = self

        
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
        
        //DOB IN USERDEFAULT.
        let dob = UserDefaults.standard.object(forKey:"DOB") as! String
        print(dob)
        
        if dob == ""
        {
            dobplaceholder.isHidden = false
        }
        else
        {
            dobBtnn.setTitle(dob, for: .normal)
            dobplaceholder.isHidden = true
        }
        
        districtplchldrLabel.isHidden = true
        statePlchldr.isHidden = true
        agencyName.text = Editagency_name
        fisrtName.text = EditFirstName
        lastName.text = EditLastNAme
        address1.text = Editaddress1
        address2.text = Editaddress2
        pincode.text = Editpin_code
        mobileNumber.text = Editmobile_number
        
        //PROFILE IMAGE.
        imageView.sd_setImage(with: URL(string: EditprofileImage!), placeholderImage: UIImage(named: "if_icons_user_1564534"))
        
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
        
        
        //IDPROOF BUTTON.
        idproofBtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        idproofBtn.layer.borderWidth = 0.5;
        idproofBtn.layer.cornerRadius = 5.0;
    }
    
    //DOB BUTTON
    @IBAction func dobBtn(_ sender: Any)
    {
        
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date)
        { (date) in
            if let dt = date
            {
                let today = NSDate()
                
                let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
                
                let age = gregorian.components([.year], from: dt, to: today as Date, options: [])
                
                if age.year! < 18
                {
                    // user is under 18
                    let alert = UIAlertController(title:"", message:"The user is under 18, you can not enroll this user." , preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                        self.hideProgress()
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else
                {
                    print("\(dt)")
                    let dateFormatter = DateFormatter()
                    
                    dateFormatter.dateFormat = "dd-MMM-yyyy" //Your New Date format as per requirement change it own
                    
                    let newDate = dateFormatter.string(from: date!) //pass Date here
                    print(newDate) //New formatted Date string
                    self.dobBtnn.setTitle(newDate, for: .normal)
                    self.dobplaceholder.isHidden = true
                }
                
                
            }
        }

        
    }
    
    //STATE BUTTON
    @IBAction func stateBtn(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "StateTableviewVC") as! StateTableviewVC
        secondViewController.Profiledelegate = self
        secondViewController.stateIdDlegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        agencyName.resignFirstResponder()
        fisrtName.resignFirstResponder()
        lastName.resignFirstResponder()
        address1.resignFirstResponder()
        address2.resignFirstResponder()
        pincode.resignFirstResponder()
        mobileNumber.resignFirstResponder()
    }
    
    @IBAction func district(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DistrictVC") as! DistrictVC
        secondViewController.districtdelegate = self
        secondViewController.districtIDdelegate = self
        secondViewController.id = stateValue
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        agencyName.resignFirstResponder()
        fisrtName.resignFirstResponder()
        lastName.resignFirstResponder()
        address1.resignFirstResponder()
        address2.resignFirstResponder()
        pincode.resignFirstResponder()
        mobileNumber.resignFirstResponder()
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
            fisrtName.resignFirstResponder()
            lastName.resignFirstResponder()
            address1.resignFirstResponder()
            address2.resignFirstResponder()
            pincode.resignFirstResponder()
            mobileNumber.resignFirstResponder()
        }
        else
        {
            print("Other Textfields")
            agencyName.resignFirstResponder()
            fisrtName.resignFirstResponder()
            lastName.resignFirstResponder()
            address1.resignFirstResponder()
            address2.resignFirstResponder()
            pincode.resignFirstResponder()
            mobileNumber.resignFirstResponder()
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
        agencyName.resignFirstResponder()
        fisrtName.resignFirstResponder()
        lastName.resignFirstResponder()
        address1.resignFirstResponder()
        address2.resignFirstResponder()
        pincode.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        
        return true;
    }
    
    
    @IBAction func submitBtnn(_ sender: Any)
    {
        if agencyName.text == Editagency_name &&  fisrtName.text == EditFirstName && lastName.text == EditLastNAme && mobileNumber.text == Editmobile_number &&  address1.text == Editaddress1 && address2.text == Editaddress2 &&  stateBTn.titleLabel?.text == EditState && districtBtn.titleLabel?.text  == EditDistrict && pincode.text == Editpin_code && imageView.image == UIImage(named: "if_icons_user_1564534")
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
            if areValidTextfields() && validMobileNumber()
            {
              self.retailer()
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
        fisrtName.resignFirstResponder()
        lastName.resignFirstResponder()
        address1.resignFirstResponder()
        address2.resignFirstResponder()
        pincode.resignFirstResponder()
        mobileNumber.resignFirstResponder()
    }
    
    
    //OPEN ACTIONSHEET WEN USER TAP ON IMAGEVIEW.
    @objc func tapOnImageview()
    {
        self.actionsheetmemberImage()
        imagePicked = 1
    }
    
    
    @IBAction func idproofImage(_ sender: Any)
    {
        self.actionsheetmemberImage()
        imagePicked = 2
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
        
        if fisrtName.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter first name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if lastName.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter last name", preferredStyle: UIAlertControllerStyle.alert)
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
        
        if dobBtnn.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select date of birth", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        
        if districtBtn.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select date of birth", preferredStyle: UIAlertControllerStyle.alert)
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
            let alert = UIAlertController(title: "", message: "Please enter pincode", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if idproofImageview.image == UIImage(named: "if_Google_Docs_-_Image_569105")
        {
            let alert = UIAlertController(title: "", message: "Please upload ID Proof Image", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
            
        }
        
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        guard let text = mobileNumber.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10
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
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
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
        present(alertVC,animated: true,completion: nil)
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
        
        dismiss(animated:true, completion: nil)
        
        if imagePicked == 1
        {
            imageView.image = chosenImage
        }
        else if imagePicked == 2
        {
            idproofImageview.image = chosenImage
        }
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
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
    
    //RETAILER PROFILE API.
    func retailer()
    {
        
        self.showProgress()
        
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
       
        //BASE64 IMAGE.
        let imageData2 = UIImageJPEGRepresentation(idproofImageview.image!, 0.1)
        print("BASE 64 \(String(describing: imageData2))")
        
        //ENCODING.
        let imageString2 = imageData2?.base64EncodedString()
       // print("image string \(String(describing: imageString2))")
        
        
        //GENDER IN USERDEFAULT.
        let gender = UserDefaults.standard.object(forKey:"Gender") as! String
        print(gender)
        
        
        let postString = Common.BaseUrl + "UpdateRetailerProfile"
        
        
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
            
            //ENCODING.
            imageString = imageData?.base64EncodedString()
            print("image string \(String(describing: imageString))")
            
        }
  
        let dateOfBirth = dobBtnn.titleLabel?.text!
        
        let newTodo: [String: Any] = ["UserId": userID ,
                                       "FirmName":agencyName.text!,
                                       "FirstName":fisrtName.text!,
                                       "LastName":lastName.text!,
                                       "MobileNumber":mobileNumber.text!,
                                       "EmailId":"",
                                       "Gender":gender,
                                       "DateofBirth":dateOfBirth!,
                                       "Address1":address1.text! ,
                                       "Address2":address2.text!,
                                       "State":stateValue!,
                                       "District":districtValu!,
                                       "ImageFileType1":"JPEG",
                                       "IdProofImage":imageString2!,
                                       "ImageFileType2":"JPEG",
                                       "ProfileImage":imageString!,
                                       "Otp":""] as [String : Any]
        
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
                    
                    self.error_code = swiftyJsonVar["UpdateRetailerProfile"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                    let result = swiftyJsonVar["UpdateRetailerProfile"]["Result"].stringValue
                    print(result)
                    
                    
                    if swiftyJsonVar["UpdateRetailerProfile"]["ErrorCode"].intValue == 0
                    {
                        print ("Success")
                        self.hideProgress()
                        
                        //BALANCE IN USERDEFAULT.
                        let blnce = UserDefaults.standard.object(forKey:"blnc") as! String
                        print(blnce)
                        
                        //MOVE TO OTP SCREEN ON SUCCESS
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "OTPScreen") as! OTPScreen
                        secondViewController.memberUserId = userID
                        secondViewController.membermobileNumber = self.mobileNumber.text!
                        secondViewController.membertyype = "Retailer"
                        secondViewController.balance = blnce
                        secondViewController.membercomapnyName = self.agencyName.text!
                        secondViewController.memberfirstName = self.fisrtName.text!
                        secondViewController.memberLastname = self.lastName.text!
                        secondViewController.memberEmailId = ""
                        secondViewController.membergender = gender
                        secondViewController.memberdob = dateOfBirth!
                        secondViewController.Idstate = self.stateValue!
                        secondViewController.IdDistrict = self.districtValu!
                        secondViewController.memberprofileImage = imageString!
                        secondViewController.memberidProofImage = imageString2!
                        secondViewController.memberaddress = self.address1.text!
                        secondViewController.memberState = self.EditState
                        secondViewController.memberDistrict = self.EditDistrict
                        
                        self.navigationController?.pushViewController(secondViewController, animated: true)
                        
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

    
                      

}
