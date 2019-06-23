//
//  MyProfileScreen.swift
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



@available(iOS 10.0, *)
class MyProfileScreen: UIViewController
{
    
    //OUTLETS.
    @IBOutlet var UserNameLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var backView: UIView!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var agencyNameLabel: UILabel!
    @IBOutlet var proprieterNameLabel: UILabel!
    @IBOutlet var mobileNumber: UILabel!
    @IBOutlet var add1Label: UILabel!
    @IBOutlet var address2Label: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var districtlabel: UILabel!
    @IBOutlet var pincodeLabel: UILabel!
    @IBOutlet var userIDLabel: UILabel!
    
    //OUTLETS FOR DEALER API.
    var error_code : Int = 0
    var Response = NSArray()
    var result = String()
    var userID = String()
    var agency_name = String()
    var properieter_name = String()
    var mobile_number = String()
    var address1 = String()
    var address2 = String()
    var State = String()
    var District = String()
    var pin_code = String()
    var profileImage = String()
    var nameString = String()
    var stateId = String()
    var districtId = String()
    
    
    //OUTLETS FOR RETAILER API.
    var firmName = String()
    var firstName = String()
    var lastName = String()
    var idproof = String()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
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
        
        
        //ROUND THE CORNERS OF BACKVIEW AND IMAGEVIEW.
//        
//        //BACKVIEW.
//        backView.layer.borderColor = UIColor.white.cgColor
//        backView.layer.borderWidth = 1.0;
//        backView.layer.cornerRadius = 50.0;
        
        
        imageview.layer.borderColor = UIColor.clear.cgColor
        imageview.layer.borderWidth = 1.0;
        imageview.layer.cornerRadius = 34.0
        imageview.clipsToBounds = true
        
        //CALL THE PROFILE API FOR SHOWING THE USER DETAILS.
        let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
        if membertype == "D"
        {
            self.profileApi()
            
        }
        else if membertype == "R"
        {
            self.retailerProfile()
        }
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
    }
    
    //EDIT BUTTON ACTION FOR MOVING TO EDIT PROFILE.
    @IBAction func editProfileBtnAction(_ sender: Any)
    {
        
        let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
        if membertype == "D"
        {
            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditMyProfileScreen") as! EditMyProfileScreen
            
            secondViewController.EdituserId = userID
            secondViewController.Editagency_name = agency_name
            secondViewController.Editproperieter_name = properieter_name
            secondViewController.Editmobile_number = mobile_number
            secondViewController.Editaddress1 = address1
            secondViewController.Editaddress2 = address2
            secondViewController.EditState = State
            secondViewController.EditDistrict = District
            secondViewController.Editpin_code = pin_code
            secondViewController.EditprofileImage = profileImage
            secondViewController.Idstate = stateId
            secondViewController.IdDistrict = districtId
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
        }
        else if membertype == "R"
        {
            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RetaileEditProfileScene") as! RetaileEditProfileScene
            
            secondViewController.Editagency_name = firmName
            secondViewController.EditFirstName = firstName
            secondViewController.EditLastNAme = lastName
            secondViewController.Editmobile_number = mobile_number
            secondViewController.Editaddress1 = address1
            secondViewController.Editaddress2 = address2
            secondViewController.EditState = State
            secondViewController.EditDistrict = District
            secondViewController.Editpin_code = pin_code
            secondViewController.EditprofileImage = profileImage
            secondViewController.idproof = idproof
            secondViewController.Idstate = stateId
            secondViewController.IdDistrict = districtId
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MY PROFILE API.
    func profileApi()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        
        let postString = Common.BaseUrl + "ViewDealerProfile"
        
        let newTodo: [String: Any] =  ["UserId": userID] as [String : Any]
        
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
                    
                    self.error_code = swiftyJsonVar["ViewDealerProfile"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                   
                    let result = swiftyJsonVar["ViewDealerProfile"]["Result"].stringValue
                    print(result)
                    
                    
                    self.Response = swiftyJsonVar["ViewDealerProfile"]["Response"].arrayValue as NSArray
                    print(self.Response)
                    
                    
                    for response in swiftyJsonVar["ViewDealerProfile"]["Response"].arrayValue
                    {
                        //USERID
                        let userID = response["UserId"].stringValue
                        self.userID.append(userID)
                        print(self.userID)
                      
                        //AGENCY NAME
                        let agencyName = response["AgencyName"].stringValue
                        self.agency_name.append(agencyName)
                        print(self.userID)
                      
                        
                        //PROPERIETER NAME.
                        let propName = response["ProprietorName"].stringValue
                        self.properieter_name.append(propName)
                        print(self.properieter_name)
                        
                        
                        //MOBILE NUMBER.
                        let mobileNum = response["MobileNumber"].stringValue
                        self.mobile_number.append(mobileNum)
                        print(self.mobile_number)
                        
                       
                        //ADDRESS1.
                        let add1 = response["Address1"].stringValue
                        self.address1.append(add1)
                        print(self.address1)
                        
                        //ADDRESS2.
                        let add2 = response["Address2"].stringValue
                        self.address2.append(add2)
                        print(self.address2)
                        
                        
                        //STATE.
                        let state = response["State"].stringValue
                        self.State.append(state)
                        print(self.State)
                        
                        
                        //DISTRICT.
                        let district = response["District"].stringValue
                        self.District.append(district)
                        print(self.District)
                        
                        //PINCODE.
                        let pin = response["Pincode"].stringValue
                        self.pin_code.append(pin)
                        print(self.pin_code)
                        
                        //PROFILE IMAGE.
                        let profileImage = response["ProfileImage"].stringValue
                        self.profileImage.append(profileImage)
                        print(self.profileImage)
                        
                        //STATE ID.
                        let stateid = response["StateId"].stringValue
                        self.stateId.append(stateid)
                        print(self.stateId)
                        
                        //DISTRICT ID.
                        let distId = response["DistrictId"].stringValue
                        self.districtId.append(distId)
                        print(self.districtId)
                     
                       
                    }
                    
                    if swiftyJsonVar["ViewDealerProfile"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                        
                        //DISPLAY USER INFO -----
                        
                        
                        //AGENCY NAME.
                        self.agencyNameLabel.text = self.agency_name
                        
                        //USER NAME.
                        self.nameLabel.text = self.properieter_name
                        
                        
                        //USER NAME.
                        self.UserNameLabel.text = self.properieter_name
                        
                        
                        //MOBILE NUMBER.
                        self.mobileNumber.text = self.mobile_number
                        
                        //ADDRESS1.
                        self.add1Label.text = self.address1
                        
                        //ADDRESS2.
                        self.address2Label.text = self.address2
                        
                        //STATE.
                        self.stateLabel.text = self.State
                        
                        //DISTRICT.
                        self.districtlabel.text = self.District
                        
                        //PINCODE.
                        self.pincodeLabel.text = self.pin_code
                    
                        
                        //PROFILE IMAGE.
                        let imagestringApi = self.profileImage
                        self.imageview.sd_setImage(with: URL(string: imagestringApi), placeholderImage: UIImage(named: "bg_profile_default"))

                       
                        //USERID.
                        self.userIDLabel.text = self.userID
                        
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
    
    //RETAILER PROFILE API.
    func retailerProfile()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        
        let postString = Common.BaseUrl + "ViewRetailerProfile"
        
        let newTodo: [String: Any] =  ["UserId": userID] as [String : Any]
        
        
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
                    
                    self.error_code = swiftyJsonVar["ViewRetailerProfile"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                    
                    let result = swiftyJsonVar["ViewRetailerProfile"]["Result"].stringValue
                    print(result)
                    
                    
                    self.Response = swiftyJsonVar["ViewRetailerProfile"]["Response"].arrayValue as NSArray
                    print(self.Response)
                    
                    
                    for response in swiftyJsonVar["ViewRetailerProfile"]["Response"].arrayValue
                    {
                        //USERID
                        let userID = response["UserId"].stringValue
                        self.userID.append(userID)
                        print(self.userID)
                        
                        
                        //FIRM NAME
                        let firmname = response["FirmName"].stringValue
                        self.firmName.append(firmname)
                        print(self.firmName)
                        
                        
                        //FIRST NAME.
                        let name = response["FirstName"].stringValue
                        self.firstName.append(name)
                        print(self.firstName)
                        
                        
                        //LAST NAME.
                        let Lname = response["LastName"].stringValue
                        self.lastName.append(Lname)
                        print(self.lastName)
                        
                        
                        //MOBILE NUMBER.
                        let mobileNum = response["MobileNumber"].stringValue
                        self.mobile_number.append(mobileNum)
                        print(self.mobile_number)
                        
                        
                        //ADDRESS1.
                        let add1 = response["Address1"].stringValue
                        self.address1.append(add1)
                        print(self.address1)
                        
                        //ADDRESS2.
                        let add2 = response["Address2"].stringValue
                        self.address2.append(add2)
                        print(self.address2)
                        
                        
                        //STATE.
                        let state = response["State"].stringValue
                        self.State.append(state)
                        print(self.State)
                        
                        
                        //DISTRICT.
                        let district = response["District"].stringValue
                        self.District.append(district)
                        print(self.District)
                        
                        //PINCODE.
                        let pin = response["Pincode"].stringValue
                        self.pin_code.append(pin)
                        print(self.pin_code)
                        
                        //PROFILE IMAGE.
                        let profileImage = response["ProfileImage"].stringValue
                        self.profileImage.append(profileImage)
                        print(self.profileImage)
                        //SAVE THE PROFILE IMAGE IN USERDEFAULT.
                        UserDefaults.standard.set(profileImage, forKey: "ProfileImage")
                        UserDefaults.standard.synchronize()
                        
                        
                        //PROFILE IMAGE.
                        let idProof = response["IdProofImage"].stringValue
                        self.idproof.append(idProof)
                        print(self.idproof)
                        
                        
                        //DOB.
                        let dob = response["DOB"].stringValue
                        UserDefaults.standard.set(dob, forKey: "DOB")
                        UserDefaults.standard.synchronize()
                        
                        //GENDER.
                        let gender = response["Gender"].stringValue
                        UserDefaults.standard.set(gender, forKey: "Gender")
                        UserDefaults.standard.synchronize()
                        
                        
                        //STATE ID.
                        let stateid = response["StateId"].stringValue
                        self.stateId.append(stateid)
                        print(self.stateId)
                        
                        //DISTRICT ID.
                        let distId = response["DistrictId"].stringValue
                        self.districtId.append(distId)
                        print(self.districtId)
                        
                    }
                    
                    if swiftyJsonVar["ViewRetailerProfile"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                        
                        //DISPLAY USER INFO -----
                        
                        //AGENCY NAME.
                        self.agencyNameLabel.text = self.agency_name
                        
                        //USER NAME.
                        let fisrtString = self.firstName
                        let secondString = self.lastName
                        self.nameString = "\(fisrtString) \(secondString)"
                        self.nameLabel.text = self.nameString

                        
                        //USER NAME.
                        self.UserNameLabel.text =  self.nameString

                        
                        //MOBILE NUMBER.
                        self.mobileNumber.text = self.mobile_number
                        
                        //ADDRESS1.
                        self.add1Label.text = self.address1
                        
                        //ADDRESS2.
                        self.address2Label.text = self.address2
                        
                        //STATE.
                        self.stateLabel.text = self.State
                        
                        //DISTRICT.
                        self.districtlabel.text = self.District
                        
                        //PINCODE.
                        self.pincodeLabel.text = self.pin_code
                        
                        
                        //PROFILE IMAGE.
                        let imagestringApi = self.profileImage
                        self.imageview.sd_setImage(with: URL(string: imagestringApi), placeholderImage: UIImage(named: "bg_profile_default"))
                        
                        
                        //USERID.
                        self.userIDLabel.text = self.userID
                        
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
