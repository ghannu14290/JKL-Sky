//
//  UpdateViewMemberVC.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 28/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import QuartzCore
import MBProgressHUD
import DatePickerDialog
import Alamofire
import SwiftyJSON


class UpdateViewMemberVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,StateProtocol, DistrictProtocol, StateIDProtocol, DistrictIDProtocol
{
    //OUTLETS.
    
    //IMAGEPICKER.
    var imagePicker = UIImagePickerController()
    
    //BUTTONS.
    @IBOutlet var districtplchldr: UILabel!
    @IBOutlet var diastrictbtn: UIButton!
    @IBOutlet var DobBtn: UIButton!
    @IBOutlet var addmemberPicbtn: UIButton!
    @IBOutlet var idProofbtn: UIButton!
    @IBOutlet var memberTypeButton: UIButton!
    @IBOutlet var genderButton: UIButton!
    @IBOutlet var stateButton: UIButton!
    @IBOutlet var statePlhldeLabel: UILabel!
    @IBOutlet var membertplhldrLabel: UILabel!
    @IBOutlet var gnderplchldrlabel: UILabel!
    @IBOutlet var dobplchldrlabel: UILabel!
    //TEXTFIELDS.
    @IBOutlet var company_name: UITextField!
    @IBOutlet var first_name: UITextField!
    @IBOutlet var last_name: UITextField!
    @IBOutlet var mobileNumber: UITextField!
    @IBOutlet var emailID: UITextField!
    @IBOutlet var address: UITextField!
    
    @IBOutlet weak var firmName: UITextField!
    //DELEGATE VALUE.
    var stateValue: String?
    var districtValu: String?
    
    var Idstate : String!
    var IdDistrict : String!
    
    //IMAGEVIES.
    @IBOutlet var memberProfilleImage: UIImageView!
    @IBOutlet var idProofImage: UIImageView!
    
    var imagePicked = 0
 
    //FOR PASSING THE VALUE TO NEXT VIEWCONTROLLER.
    var memberUserId = String()
    var membermobileNumber = String()
    var memberName = String()
    var membertype = String()
    var balance = String()
    var membercomapnyName = String()
    var memberfirstName = String()
    var memberLastname = String()
    var memberEmailId = String()
    var membergender = String()
    var memberdob = String()
    var memberState = String()
    var memberDistrict = String()
    var memberprofileImage = String()
    var memberidProofImage = String()
    var memberaddress = String()
    var firmNameFrom = String()


    override func viewDidLoad()
    {
        super.viewDidLoad()

        print("id state \(Idstate)")
        print("district id \(IdDistrict)")
        
        
        //NAVIGATION BAR
        self.navigationItem.title = "Update Member"
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
        
        
        
        //CALL FUNCTION FOR SET THE BORDER OF BUTTON AND ITS COLOR.
        self.chnageBorder()
    
        //CALL FUNCTION FOR DELEAGETS.
        self.callDelegates()
        
        //CALL GESTURE FUNC FOR USING THE TAP FUNCTION.
        self.gestureFunctions()

        
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
        
        if membertype == "Retailer"
        {
        firmName.isHidden = false
        }
        
        self.displayDetails()

    }
    
    //PROTOCOL DELEGATE METHOD.
    func EDITPstateName(valueSent: String)
    {
        
        print("valueSent is \(valueSent)")
        statePlhldeLabel.isHidden = true
        stateButton.setTitle(valueSent, for: .normal)
        
    }
    
    func EDITPdistrictName(valueSent: String)
    {
        districtplchldr.isHidden = true
        diastrictbtn.setTitle(valueSent, for: .normal)
    }
    
    func EDITPstateID(valueSent: String)
    {
        
        print("StateId is \(valueSent)")

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
      self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if firmName.text == "Retailer"
        {
            firmName.isHidden = false
        }

        //DISPLAY DETAILS OF MEMBER.
     //   self.displayDetails()
        
    }
    
    //DISPLAY DETAILS OF MEMBER.
    func displayDetails()
    {
        
        if memberdob == ""
        {
            dobplchldrlabel.isHidden = false
        }
        else
        {
            DobBtn.setTitle(memberdob, for: .normal)
            dobplchldrlabel.isHidden = true
        }
        
        if membergender  == ""
        {
            gnderplchldrlabel.isHidden = false
            
        }
        else
        {
            genderButton.setTitle(membergender, for: .normal)
            gnderplchldrlabel.isHidden = true
        }
        
        if memberState == ""
        {
            statePlhldeLabel.isHidden = false
            
        }
        else
        {
            stateButton.setTitle(memberState, for: .normal)
            statePlhldeLabel.isHidden = true
        }
        
        
        if memberDistrict == ""
        {
            districtplchldr.isHidden = false
            
        }
        else
        {
            diastrictbtn.setTitle(memberDistrict, for: .normal)
            districtplchldr.isHidden = true
        }
        
        mobileNumber.text = membermobileNumber
        first_name.text = memberfirstName
        last_name.text = memberLastname
        address.text = memberaddress
        emailID.text = memberEmailId
        firmName.text = firmNameFrom

        let proImage = memberprofileImage
        memberProfilleImage.sd_setImage(with: URL(string: proImage), placeholderImage: UIImage(named: "if_Google_Docs_-_Image_569105"))
        
        let proofImage = memberidProofImage
        idProofImage.sd_setImage(with: URL(string: proofImage), placeholderImage: UIImage(named: "if_Google_Docs_-_Image_569105"))
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //FUNCTION FOR SET THE BORDER OF BUTTON AND ITS COLOR.
    func chnageBorder()
    {
        //MEMBER TYPE BUTTON.
        memberTypeButton.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        memberTypeButton.layer.borderWidth = 0.5;
        memberTypeButton.layer.cornerRadius = 5.0;
        
        
        //GENDER BUTTON.
        genderButton.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        genderButton.layer.borderWidth = 0.5;
        genderButton.layer.cornerRadius = 5.0;
        
        
        //STATE BUTTON.
        stateButton.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        stateButton.layer.borderWidth = 0.5;
        stateButton.layer.cornerRadius = 5.0;
        
        
        //ADD MEMBER PHOTO BUTTON.
        addmemberPicbtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        addmemberPicbtn.layer.borderWidth = 0.5;
        addmemberPicbtn.layer.cornerRadius = 5.0;
        
        
        //ADD ID PROOF BUTTON.
        idProofbtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        idProofbtn.layer.borderWidth = 0.5;
        idProofbtn.layer.cornerRadius = 5.0;
        
        //DOB BUTTON.
        DobBtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        DobBtn.layer.borderWidth = 0.5;
        DobBtn.layer.cornerRadius = 5.0;
        
        //DISTRICT BUTTON.
        diastrictbtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        diastrictbtn.layer.borderWidth = 0.5;
        diastrictbtn.layer.cornerRadius = 5.0;
        
    }
    
    
    @IBAction func districtBtn(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DistrictVC") as! DistrictVC
        secondViewController.districtdelegate = self
        secondViewController.districtIDdelegate = self
        secondViewController.id = stateValue
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        company_name.resignFirstResponder()
        first_name.resignFirstResponder()
        last_name.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        emailID.resignFirstResponder()
        address.resignFirstResponder()

    }
    
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
                    self.DobBtn.setTitle(newDate, for: .normal)
                    self.dobplchldrlabel.isHidden = true
                }
            }
            
        }
    }
    
    @IBAction func addmemberpicButtnl(_ sender: Any)
    {
        self.actionsheetmemberImage()
        imagePicked = 1
    }
    
    @IBAction func ifproofbtn(_ sender: Any)
    {
        self.actionsheetmemberImage()
        imagePicked = 2
    }
    
    @IBAction func submitbtn(_ sender: Any)
    {
       
          if mobileNumber.text != ""
          {
            if self.validMobileNumber()
            {
            
                if membertype == "Retailer"
                {
                    if self.areValidRetailer()
                    {
                   self.retailer()
                    }
                }
                
                else if membertype == "Influencer"
                {
                    self.influencer()
                }
              }
           }
            else if emailID.text != ""
            {
                if self.email()
                {
                    
                    if membertype == "Retailer"
                    {
                        self.retailer()
                    }
                        
                    else if membertype == "Influencer"
                    {
                        self.influencer()
                    }
                }
            }
                
            else
            {
                let alert = UIAlertController(title:"", message:"Invalid member type, please try again! " , preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                   self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    
    @IBAction func statebtn(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "StateTableviewVC") as! StateTableviewVC
        secondViewController.Profiledelegate = self
        secondViewController.stateIdDlegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        first_name.resignFirstResponder()
        last_name.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        emailID.resignFirstResponder()
        address.resignFirstResponder()

    }
    
    @IBAction func memberType(_ sender: Any)
    {
        
//        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
//        
//        actionSheet.addAction(UIAlertAction(title: "Retailer", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
//            
//            self.memberTypeButton.setTitle( "Retailer", for: .normal)
//            self.membertplhldrLabel.isHidden = true
//            
//        }))
//        
//        actionSheet.addAction(UIAlertAction(title: "Influencer", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
//            
//            self.memberTypeButton.setTitle( "Influencer", for: .normal)
//            self.membertplhldrLabel.isHidden = true
//        }))
//        
//        
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (alert:UIAlertAction!) -> Void in
//            
//            self.memberTypeButton.setTitle( "", for: .normal)
//            self.membertplhldrLabel.isHidden = false
//        }))
//        
//        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func genderBtn(_ sender: Any)
    {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Male", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.genderButton.setTitle( "Male", for: .normal)
            self.gnderplchldrlabel.isHidden = true
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Female", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.genderButton.setTitle( "Female", for: .normal)
            self.gnderplchldrlabel.isHidden = true
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (alert:UIAlertAction!) -> Void in
            
            self.genderButton.setTitle( "", for: .normal)
            self.gnderplchldrlabel.isHidden = false
            
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    //TEXTFIELD DELEGATE METHODS
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField.tag == 4
        {
            guard let text = mobileNumber.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 10
        }
        return true
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if  textField.tag == 7 || textField.tag == 8
        {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y-200, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
        else
        {            print("Other Textfields")
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
        
        if textField.tag == 6 || textField.tag == 7 || textField.tag == 8
        {
            
           
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y+200, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
            
            
        }
        else
        {
            
            print("Other Textfields")
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
        first_name.resignFirstResponder()
        last_name.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        emailID.resignFirstResponder()
        address.resignFirstResponder()
        
        return true;
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
        first_name.resignFirstResponder()
        last_name.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        emailID.resignFirstResponder()
        address.resignFirstResponder()
    }
    
    //DELEGATES CALLING OF TEXTFIELDS.
    func callDelegates()
    {
        self.first_name.delegate = self
        self.last_name.delegate = self
        self.mobileNumber.delegate = self
        self.emailID.delegate = self
        self.address.delegate = self
        
    }
    
    
    //SHOW ACTION SHEET FOR IMAGE PICKER.
    
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
            imagePicker.allowsEditing = false
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
            memberProfilleImage.image = chosenImage
        }
        else if imagePicked == 2
        {
            idProofImage.image = chosenImage
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
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
    
    //VALIDATIONS OF TEXTFIELDS.
    
    
    func areValidRetailer() -> Bool
    {
        if firmName.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter firm name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }

        if first_name.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter first name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if mobileNumber.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter mobile No.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true

    }
    
    func areValidTextfields() -> Bool
    {

        if first_name.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter first name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if last_name.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter last name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        
       
        if genderButton.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select gender", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if DobBtn.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select date of birth", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if address.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter address", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        
        if stateButton.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select state", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if diastrictbtn.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please enter district", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        
 return true

    }
    
    //VALID EMAIL ID.
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func email() -> Bool
    {
        if isValidEmail(testStr:emailID.text!)
        {
            print("Valid Email Id")
        }
        else
        {
            let alert = UIAlertController(title: "", message: "Please enter valid email Id", preferredStyle: UIAlertControllerStyle.alert)
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

    
    //RETAILER PROFILE API.
    func retailer()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        //BASE64 IMAGE PROFILE
        let imageData = UIImageJPEGRepresentation(memberProfilleImage.image!,  0.1)
        print("BASE 64 \(String(describing: imageData))")
        
        //ENCODING.
        let imageString = imageData?.base64EncodedString()
        print("ima string \(String(describing: imageString))")
        
        
        //BASE64 IMAGE PROFILE
        let imageData2 = UIImageJPEGRepresentation(idProofImage.image!,  0.1)
        print("BASE 64 \(String(describing: imageData2))")
        
        //ENCODING.
        let imageString2 = imageData2?.base64EncodedString()
        print("image string \(String(describing: imageString2))")
       
        let postString = Common.BaseUrl + "UpdateRetailerProfile"
       
        let newTodo: [String: Any] =  ["UserId": userID,
                                       "FirmName":firmName.text!,
                                       "FirstName":first_name.text!,
                                       "LastName":last_name.text!,
                                       "MobileNumber":mobileNumber.text!,
                                       "EmailId":emailID.text!,
                                       "Gender":genderButton.titleLabel?.text as Any,
                                       "DateofBirth":DobBtn.titleLabel?.text as Any,
                                       "Address1": address.text! ,
                                       "Address2":"",
                                       "State": stateValue!,
                                       "District": districtValu!,
                                       "ImageFileType1":"JPEG",
                                       "IdProofImage" :imageString2!,
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
                    
                    
                    let result = swiftyJsonVar["UpdateRetailerProfile"]["Result"].stringValue
                    print(result)
                    
                    
                    if swiftyJsonVar["UpdateRetailerProfile"]["ErrorCode"].intValue == 0
                    {
                        print ("Success")
                        self.hideProgress()
                        
                            //MOVE TO OTP SCREEN ON SUCCESS
                            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "OTPScreen") as! OTPScreen
                            secondViewController.memberUserId = self.memberUserId
                            secondViewController.membermobileNumber = self.mobileNumber.text!
                            secondViewController.memberName = self.memberName
                            secondViewController.membertyype = self.membertype
                            secondViewController.balance = self.balance
                            secondViewController.memberfirstName = self.memberfirstName
                            secondViewController.memberLastname = self.memberLastname
                            secondViewController.memberEmailId = self.emailID.text!
                            secondViewController.membergender = (self.genderButton.titleLabel?.text)!
                            secondViewController.memberdob = self.memberdob
                            secondViewController.Idstate = self.stateValue!
                            secondViewController.IdDistrict = self.districtValu!
                            secondViewController.memberprofileImage = imageString!
                            secondViewController.memberidProofImage = imageString2!
                            secondViewController.memberaddress = self.memberaddress
                            secondViewController.memberState = self.memberState
                            secondViewController.memberDistrict = self.memberDistrict
                            
                            self.navigationController?.pushViewController(secondViewController, animated: true)
                      
                        
                    }
                        
                    else
                    {
                        self.hideProgress()
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
    
    
    //INFLUENCER PROFILE API.
    func influencer()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        //BASE64 IMAGE PROFILE
        let imageData = UIImageJPEGRepresentation(memberProfilleImage.image!,  0.1)
        print("BASE 64 \(String(describing: imageData))")
        
        //ENCODING.
        let imageString = imageData?.base64EncodedString()
        print("image string \(String(describing: imageString))")
        
        
        //BASE64 IMAGE PROFILE
        let imageData2 = UIImageJPEGRepresentation(idProofImage.image!,  0.1)
        print("BASE 64 \(String(describing: imageData2))")
        
        //ENCODING.
        let imageString2 = imageData2?.base64EncodedString()
        print("image string \(String(describing: imageString2))")
        
        let gender = genderButton.currentTitle
        let dob = DobBtn.currentTitle

        let postString = Common.BaseUrl + "UpdateInfluencerProfile"
        
        let newTodo: [String: Any] =  ["UserId": userID,
                                       "FirstName":first_name.text!,
                                       "LastName":last_name.text!,
                                       "MobileNumber":mobileNumber.text!,
                                       "EmailId":emailID.text!,
                                       "Gender":gender ?? "",
                                       "DateofBirth":dob ?? "",
                                       "Address1": address.text! ,
                                       "Address2":"",
                                       "State": stateValue!,
                                       "District": districtValu!,
                                       "ImageFileType1":"JPEG",
                                       "IdProofImage" :imageString2!,
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
                    
                    
                    let result = swiftyJsonVar["UpdateInfluencerProfile"]["Result"].stringValue
                    print(result)
                    
                    
                    if swiftyJsonVar["UpdateInfluencerProfile"]["ErrorCode"].intValue == 0
                    {
                        print ("Success")
                        self.hideProgress()
                        //MOVE TO OTP SCREEN ON SUCCESS
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "OTPScreen") as! OTPScreen
                        secondViewController.memberUserId = self.memberUserId
                        secondViewController.membermobileNumber = self.mobileNumber.text!
                        secondViewController.memberName = self.memberName
                        secondViewController.membertyype = self.membertype
                        secondViewController.balance = self.balance
                        secondViewController.memberfirstName = self.memberfirstName
                        secondViewController.memberLastname = self.memberLastname
                        secondViewController.memberEmailId = self.emailID.text!
                        secondViewController.membergender = (self.genderButton.titleLabel?.text)!
                        secondViewController.memberdob = self.memberdob
                        secondViewController.Idstate = self.stateValue!
                        secondViewController.IdDistrict = self.districtValu!
                        secondViewController.memberprofileImage = imageString!
                        secondViewController.memberidProofImage = imageString2!
                        secondViewController.memberaddress = self.memberaddress
                        secondViewController.memberState = self.memberState
                        secondViewController.memberDistrict = self.memberDistrict

                        
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
