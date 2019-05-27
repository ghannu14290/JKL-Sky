//
//  AddMemberScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 18/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import QuartzCore
import MBProgressHUD
import DatePickerDialog
import Alamofire
import SwiftyJSON


class AddMemberScreen: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,StateProtocol, DistrictProtocol,StateIDProtocol, DistrictIDProtocol, UIScrollViewDelegate
{
    //OUTLETS.
    
    //IMAGEPICKER.
    var imagePicker = UIImagePickerController()
    
    //SCROLLVIEW
    @IBOutlet var scrollView: UIScrollView!
    
    //BUTTONS.
    @IBOutlet var districtbtn: UIButton!
    @IBOutlet var DobBtn: UIButton!
    @IBOutlet var addmemberPicbtn: UIButton!
    @IBOutlet var idProofbtn: UIButton!
    @IBOutlet var memberTypeButton: UIButton!
    @IBOutlet var genderButton: UIButton!
    @IBOutlet var stateButton: UIButton!
    @IBOutlet var addMemberphotbtn: UIButton!
    @IBOutlet var idProofBtn: UIButton!
    @IBOutlet var statePlhldeLabel: UILabel!
    @IBOutlet var membertplhldrLabel: UILabel!
    @IBOutlet var gnderplchldrlabel: UILabel!
    @IBOutlet var dobplchldrlabel: UILabel!
    @IBOutlet var districplchldr: UILabel!
    
    //TEXTFIELDS.
   
    @IBOutlet var company_name: UITextField!
    @IBOutlet var first_name: UITextField!
    @IBOutlet var last_name: UITextField!
    @IBOutlet var mobileNumber: UITextField!
    @IBOutlet var emailID: UITextField!
    @IBOutlet var address: UITextField!
     //DELEGATE VALUE.
    var stateValue: String?
     var districtValu: String?  
    //IMAGEVIES.
    @IBOutlet var memberProfilleImage: UIImageView!
    @IBOutlet var idProofImage: UIImageView!
    
     var imagePicked = 0
    
    @IBOutlet var arrowBttnImage: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //NAVIGATION BAR
        self.navigationItem.title = "Add Member"
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
        
        
        //CALL THE FUNCTION FOR SETTING THE BUTTON'S BORDER COLOR
        self.chnageBorder()
        
        //CALL FUNCTION FOR DELEAGETS.
        self.callDelegates()
        
        //CALL GESTURE FUNC FOR USING THE TAP FUNCTION.
        self.gestureFunctions()
        
        //CHECK PROTOCOL DELEGATE MTHOD VALUE.
        
        if stateValue == nil
        {
            statePlhldeLabel.isHidden = false
            print("Value from display = \(String(describing: stateValue))")
        }
        
        //DELEGATE OF SCROLLVIEW.
        self.scrollView.delegate = self
    }
    
    //DELEGATES CALLING OF TEXTFIELDS.
    func callDelegates()
    {
        self.company_name.delegate = self
        self.first_name.delegate = self
        self.last_name.delegate = self
        self.mobileNumber.delegate = self
        self.emailID.delegate = self
        self.address.delegate = self
       
    }
    
    //PROTOCOL DELEGATE METHOD.
    func EDITPstateName(valueSent: String)
    {
        statePlhldeLabel.isHidden = true
        stateButton.setTitle(valueSent, for: .normal)
        
    }
    
    func EDITPdistrictName(valueSent: String)
    {
         districplchldr.isHidden = true
        districtbtn.setTitle(valueSent, for: .normal)
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
        addMemberphotbtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        addMemberphotbtn.layer.borderWidth = 0.5;
        addMemberphotbtn.layer.cornerRadius = 5.0;
        
        
    //ADD ID PROOF BUTTON.
        idProofBtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        idProofBtn.layer.borderWidth = 0.5;
        idProofBtn.layer.cornerRadius = 5.0;
        
    //DOB BUTTON.
        DobBtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        DobBtn.layer.borderWidth = 0.5;
        DobBtn.layer.cornerRadius = 5.0;
        
    //DISTRICT BUTTON.
        districtbtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        districtbtn.layer.borderWidth = 0.5;
        districtbtn.layer.cornerRadius = 5.0;
     }
    
//    override func viewWillAppear(_ animated: Bool)
//    {
//        super.viewWillAppear(true)
//        
//        
//        if stateValue != nil
//        {
//            if memberTypeButton.titleLabel?.text == "Retailer"
//            {
//                self.membertplhldrLabel.isHidden = true
//                
//                
//                //CHANGE MEMBER TYPE FRAME
//                self.memberTypeButton.frame = CGRect(x: 11, y: 6, width: 295, height: 30)
//                self.membertplhldrLabel.frame = CGRect(x: 22, y: 9, width: 198, height: 20)
//                self.arrowBttnImage.frame = CGRect(x: 279, y: 9, width: 20, height: 20)
//                
//                
//                //CHNAGE RETAILER ID FRAME
//                //self.retailerID.frame = CGRect(x: 11, y: 41, width: 295, height: 30)
//                
//                
//                //CHANGE FIRM NAME FRAME.
//                self.company_name.frame = CGRect(x: 11, y: 78, width: 295, height: 30)
//                
//                
//                self.company_name.isHidden = false
//            }
//                
//            else
//            {
//                //CHNAGE RETAILER ID FRAME
//                //self.retailerID.frame = CGRect(x: 11, y: 78, width: 295, height: 30)
//                
//                //CHANGE MEMBER TYPE FRAME
//                self.memberTypeButton.frame = CGRect(x: 11, y: 41, width: 295, height: 30)
//                self.membertplhldrLabel.frame = CGRect(x: 22, y: 46, width: 198, height: 20)
//                self.arrowBttnImage.frame = CGRect(x: 279, y: 46, width: 20, height: 20)
//                
//                self.membertplhldrLabel.isHidden = true
//            }
//        }
//    }
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
    }
    
    @IBAction func memberTypeBTn(_ sender: Any)
    {
       self.MemberTypeActionSheet()
    }
    
    @IBAction func genderbTn(_ sender: Any)
    {
       self.GenderActionSHeet()
    }
    
    @IBAction func stateBtn(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "StateTableviewVC") as! StateTableviewVC
        secondViewController.Profiledelegate = self
        secondViewController.stateIdDlegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        company_name.resignFirstResponder()
        first_name.resignFirstResponder()
        last_name.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        emailID.resignFirstResponder()
        address.resignFirstResponder()
    }
    
    @IBAction func districtbtnaction(_ sender: Any)
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
    
    
    @IBAction func addMemberPhoto(_ sender: Any)
    {
        self.actionsheetmemberImage()
        imagePicked = 1
        
    }
    
    @IBAction func idProofBtn(_ sender: Any)
    {
        self.actionsheetmemberImage()
        imagePicked = 2
    }
    
    

    //SHOW ACTION SHEET.
    func MemberTypeActionSheet()
    {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Retailer", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.memberTypeButton.setTitle( "Retailer", for: .normal)
            self.membertplhldrLabel.isHidden = true
            
            
            //CHANGE MEMBER TYPE FRAME
            self.memberTypeButton.frame = CGRect(x: 11, y: 21, width: 295, height: 30)
            self.membertplhldrLabel.frame = CGRect(x: 22, y: 24, width: 198, height: 20)
            self.arrowBttnImage.frame = CGRect(x: 279, y: 24, width: 20, height: 20)
            
            
            //CHNAGE RETAILER ID FRAME
          //  self.retailerID.frame = CGRect(x: 11, y: 41, width: 295, height: 30)
            
            
            //CHANGE FIRM NAME FRAME.
            self.company_name.frame = CGRect(x: 11, y: 58, width: 295, height: 30)
            
            
             self.company_name.isHidden = false
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Mason", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.memberTypeButton.setTitle( "Mason", for: .normal)
             self.company_name.isHidden = true
            
            //CHNAGE RETAILER ID FRAME
            // self.retailerID.frame = CGRect(x: 11, y: 78, width: 295, height: 30)
            
            //CHANGE MEMBER TYPE FRAME
             self.memberTypeButton.frame = CGRect(x: 11, y: 58, width: 295, height: 30)
             self.membertplhldrLabel.frame = CGRect(x: 22, y: 65, width: 198, height: 20)
             self.arrowBttnImage.frame = CGRect(x: 279, y: 65, width: 20, height: 20)
            
            self.membertplhldrLabel.isHidden = true
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Contractor", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.memberTypeButton.setTitle( "Contractor", for: .normal)
            self.company_name.isHidden = true
            
            //CHNAGE RETAILER ID FRAME
        //    self.retailerID.frame = CGRect(x: 11, y: 78, width: 295, height: 30)
            
            //CHANGE MEMBER TYPE FRAME
            self.memberTypeButton.frame = CGRect(x: 11, y: 58, width: 295, height: 30)
            self.membertplhldrLabel.frame = CGRect(x: 22, y: 65, width: 198, height: 20)
            self.arrowBttnImage.frame = CGRect(x: 279, y: 65, width: 20, height: 20)
            
            self.membertplhldrLabel.isHidden = true
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (alert:UIAlertAction!) -> Void in
            
            self.memberTypeButton.setTitle( "", for: .normal)
             self.membertplhldrLabel.isHidden = false
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    func GenderActionSHeet()
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
    
    
    @IBAction func dobBtnAction(_ sender: Any)
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
                    self.DobBtn.setTitle(newDate, for: .normal)
                    self.dobplchldrlabel.isHidden = true
                    }
   
                    
                }
            }
      }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TEXTFIELDS DELEGATES.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField.tag == 5
        {
        guard let text = mobileNumber.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if memberTypeButton.titleLabel?.text == "Retailer"
        {
            self.membertplhldrLabel.isHidden = true
            
            
            //CHANGE MEMBER TYPE FRAME
            self.memberTypeButton.frame = CGRect(x: 11, y: 21, width: 295, height: 30)
            self.membertplhldrLabel.frame = CGRect(x: 22, y: 24, width: 198, height: 20)
            self.arrowBttnImage.frame = CGRect(x: 279, y: 24, width: 20, height: 20)
            
            
            //CHANGE FIRM NAME FRAME.
            self.company_name.frame = CGRect(x: 11, y: 58, width: 295, height: 30)
            
            
            self.company_name.isHidden = false
        }
            
        else
        {
            //CHNAGE RETAILER ID FRAME
           // self.retailerID.frame = CGRect(x: 11, y: 78, width: 295, height: 30)
            
            //CHANGE MEMBER TYPE FRAME
            self.memberTypeButton.frame = CGRect(x: 11, y: 58, width: 295, height: 30)
            self.membertplhldrLabel.frame = CGRect(x: 22, y: 65, width: 198, height: 20)
            self.arrowBttnImage.frame = CGRect(x: 279, y: 65, width: 20, height: 20)
            
            self.membertplhldrLabel.isHidden = true
        }

        
        if textField.tag == 6 || textField.tag == 7 || textField.tag == 8
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
          if memberTypeButton.titleLabel?.text == "Retailer"
            {
                self.membertplhldrLabel.isHidden = true

                //CHANGE MEMBER TYPE FRAME
                self.memberTypeButton.frame = CGRect(x: 11, y: 21, width: 295, height: 30)
                self.membertplhldrLabel.frame = CGRect(x: 22, y: 24, width: 198, height: 20)
                self.arrowBttnImage.frame = CGRect(x: 279, y: 24, width: 20, height: 20)

                //CHANGE FIRM NAME FRAME.
                self.company_name.frame = CGRect(x: 11, y: 58, width: 295, height: 30)

                self.company_name.isHidden = false
                
            }

            else
            {
               //CHANGE MEMBER TYPE FRAME
                self.memberTypeButton.frame = CGRect(x: 11, y: 58, width: 295, height: 30)
                self.membertplhldrLabel.frame = CGRect(x: 22, y: 65, width: 198, height: 20)
                self.arrowBttnImage.frame = CGRect(x: 279, y: 65, width: 20, height: 20)
                
                self.membertplhldrLabel.isHidden = true
            }

        
        if textField.tag == 6 || textField.tag == 7 || textField.tag == 8
        {
       
         self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y+150, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
            
            
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
        
        if memberTypeButton.titleLabel?.text == "Retailer"
        {
            self.membertplhldrLabel.isHidden = true
            
            
            //CHANGE MEMBER TYPE FRAME
            self.memberTypeButton.frame = CGRect(x: 11, y: 21, width: 295, height: 30)
            self.membertplhldrLabel.frame = CGRect(x: 22, y: 24, width: 198, height: 20)
            self.arrowBttnImage.frame = CGRect(x: 279, y: 24, width: 20, height: 20)
            
            
            
            //CHANGE FIRM NAME FRAME.
            self.company_name.frame = CGRect(x: 11, y: 58, width: 295, height: 30)
            
            
            self.company_name.isHidden = false
        }
            
        else
        {
            //CHNAGE RETAILER ID FRAME
            //self.retailerID.frame = CGRect(x: 11, y: 78, width: 295, height: 30)
            
            //CHANGE MEMBER TYPE FRAME
            self.memberTypeButton.frame = CGRect(x: 11, y: 58, width: 295, height: 30)
            self.membertplhldrLabel.frame = CGRect(x: 22, y: 65, width: 198, height: 20)
            self.arrowBttnImage.frame = CGRect(x: 279, y: 65, width: 20, height: 20)
            
            self.membertplhldrLabel.isHidden = true
        }

        
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
        company_name.resignFirstResponder()
        first_name.resignFirstResponder()
        last_name.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        emailID.resignFirstResponder()
        address.resignFirstResponder()
    }
    
    
    //VALIDATIONS OF TEXTFIELDS.
    
    func areValidTextfields() -> Bool
    {
        if memberTypeButton.titleLabel?.text == "Retailer"
        {
            
            if memberTypeButton.titleLabel?.text == nil
            {
                let alert = UIAlertController(title: "", message: "Please select type of member", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            
            
            if company_name.text == ""
            {
                let alert = UIAlertController(title: "", message: "Please enter name of the company", preferredStyle: UIAlertControllerStyle.alert)
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
            
            if last_name.text == ""
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
            
            if emailID.text == ""
            {
                let alert = UIAlertController(title: "", message: "Please enter email Id", preferredStyle: UIAlertControllerStyle.alert)
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
            
            if districtbtn.titleLabel?.text == nil
            {
                let alert = UIAlertController(title: "", message: "Please select district", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            
            if idProofImage.image == UIImage(named: "if_Google_Docs_-_Image_569105")
            {
                let alert = UIAlertController(title: "", message: "Please upload ID Proof Image", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
                
            }

            
       }
        else
        {
            if memberTypeButton.titleLabel?.text == nil
            {
                let alert = UIAlertController(title: "", message: "Please select type of member", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
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
            
            if last_name.text == ""
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
            
            if emailID.text == ""
            {
                let alert = UIAlertController(title: "", message: "Please enter email Id", preferredStyle: UIAlertControllerStyle.alert)
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
            
            if districtbtn.titleLabel?.text == nil
            {
                let alert = UIAlertController(title: "", message: "Please select district", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            
            if idProofImage.image == UIImage(named: "if_Google_Docs_-_Image_569105")
            {
                let alert = UIAlertController(title: "", message: "Please upload ID Proof Image", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false

            }
            
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
            self.hideProgress()
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
            self.hideProgress()
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return true
    }

    
    //SUBMIT BUTTON.
     @IBAction func submitButton(_ sender: Any)
    {
        
        if areValidTextfields() && validMobileNumber() && email()
        {
            
            self.addMemberApi()
        }
        else
        {
            
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
    
    
    
    //AD MEMBER API.
    func addMemberApi()
    {
        //USERID IN USERDEFAULT.
        
        
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        
        self.showProgress()
        
        //BASE64 IDPROOF IMAGE.
        let IdProofimageData = UIImageJPEGRepresentation(idProofImage.image!, 0.1)
        print("BASE 64 \(String(describing: IdProofimageData))")
        
        let IdProofimageDataString = IdProofimageData?.base64EncodedString()
        print("image string \(String(describing: IdProofimageDataString))")
        
        
        //STATE ID IN USERDEFAULZT.
        let stateID = UserDefaults.standard.object(forKey:"stateID") as! String
        print(stateID)
        
        //DISTRICT ID IN USERDEFAULZT.
        let districtId = UserDefaults.standard.object(forKey:"districtID") as! String
        print(districtId)
        
        let membertypeString = memberTypeButton.titleLabel?.text
        let genderString = genderButton.titleLabel?.text
        let dateString =  DobBtn.titleLabel?.text
        
        let postString = "http://jklsky.com/api/Service.svc/NewEnrollment"
        
        let MemberProfileimageDataString:String!
        
        if memberProfilleImage.image == UIImage(named: "if_Google_Docs_-_Image_569105")
        {
           MemberProfileimageDataString = ""
            
        }
        else
        {
            //BASE64 PROFILE IMAGE.
            let MemberProfileimageData = UIImageJPEGRepresentation(memberProfilleImage.image!, 0.1)
            print("BASE 64 \(String(describing: MemberProfileimageData))")
            
             MemberProfileimageDataString = MemberProfileimageData?.base64EncodedString()
            print("image string \(String(describing: MemberProfileimageData))")
            
        }
        
        let newTodo: [String: Any] =  ["UserId":userID,
                                       "RetailerId":"",
                                       "MemberType": membertypeString!,
                                       "FirmName": company_name.text!,
                                       "FirstName": first_name.text!,
                                       "LastName": last_name.text!,
                                       "MobileNumber": mobileNumber.text!,
                                       "EmailId":emailID.text!,
                                       "Gender": genderString! ,
                                       "DateofBirth": dateString!,
                                       "Address1": address.text!,
                                       "Address2":"",
                                       "State": stateValue!,
                                       "District": districtValu!,
                                       "ImageFileType1":"JPEG",
                                       "IdProofImage" :IdProofimageDataString!,
                                       "ImageFileType2":"JPEG",
                                       "ProfileImage":MemberProfileimageDataString!] as [String : Any]
        
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
                    
                    let result = swiftyJsonVar["NewEnrollment"]["Result"].stringValue
                    
                    if swiftyJsonVar["NewEnrollment"]["Result"].stringValue == "Success"
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
                            
                            self.hideProgress()

                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }
                    
                    
                    
                }
                
                
        }
        
        
    }
    
    
}
