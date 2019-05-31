//
//  HomeScreen.swift
//  JKL SKY APP
//
//  Created by Ramandeep Singh Bakshi on 16/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import QuartzCore
import SDWebImage
import SwiftyJSON
import Alamofire
import MBProgressHUD


class HomeScreen: UIViewController
{
    //OUTLETS.
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var mobile_numberLabel: UILabel!
    @IBOutlet var Sap_codeLabel: UILabel!
    @IBOutlet var imageBackView: UIView!
    @IBOutlet var profileImageview: UIImageView!
    @IBOutlet var tierLevel: UILabel!
    @IBOutlet var bonuspoints: UILabel!
    var checkViewController: String!
    @IBOutlet var scrollview: UIScrollView!
    
    //FOR LIST VIEWS.
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var view5: UIView!
    
    //OUTLETS FOR API.
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
    var tierlevel = String()
    
    //OUTLETS FOR RETAILER API.
    var firmName = String()
    var firstName = String()
    var lastName = String()
    var nameString = String()
    
    
    //OULETS FOR HOME API.
    var memberName = String()
    var mobnumber = String()
    var bonusPoints = String()
    var profImage = String()
    var tiername = String()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        //CALL THE HOME API FUNCTION
         self.showProgress()
        self.homeAPI()
        
        //CALL THE PROFILE API.
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
        
        
        
        //NAVIGATION BAR
        self.navigationItem.title = "JK Lakshmi Sky"
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 32/255, green: 95/255, blue: 166/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        
        //NOTIFICATION ON NAVIGATION BAR.
        let backButn: UIButton = UIButton()
        backButn.setImage(UIImage(named: "ic_action_bell"), for: .normal)
        backButn.frame = CGRect(x: 0,y: 0,width: 30,height: 30)
        backButn.addTarget(self, action: #selector(notificationScreen), for:.touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: backButn), animated: true)
        
        
        //ROUND THE CORNER RADIUS OF IMAGE BACK VIEW.
        profileImageview.layer.borderColor = UIColor.clear.cgColor
        profileImageview.layer.borderWidth = 1;
        profileImageview.layer.cornerRadius = 30.0;
        
        
        //SET THE BORDER COLOR OF LIST VIEWS.
        
        //1
        view1.layer.borderColor = UIColor.lightGray.cgColor
        view1.layer.borderWidth = 0.5;
        
        //2
        view2.layer.borderColor = UIColor.lightGray.cgColor
        view2.layer.borderWidth = 0.5;
        
        //3
        view3.layer.borderColor = UIColor.lightGray.cgColor
        view3.layer.borderWidth = 0.5;
        
         //4
        view4.layer.borderColor = UIColor.lightGray.cgColor
        view4.layer.borderWidth = 0.5;
        
        //5
        view5.layer.borderColor = UIColor.lightGray.cgColor
        view5.layer.borderWidth = 0.5;
        
        
        //CALL THE GESTURE FUNCTION.
        self.gestureFunctions()
        
        //CALL THE FUNCTION FOR SHOWING THE LIST VIEWS ACCORDING TO MEMBER TYPE.
        self.checkMemberType()
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       
      
    }
    
    
    //MOVE TO NOTIFICATION SCREEN
    @objc func notificationScreen()
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotificationScreen") as! NotificationScreen
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
//    
//    //DISPLAY DETAILS.
//    func details()
//    {
//       
//            //DISPLAY USERANEME.
//            let username = UserDefaults.standard.object(forKey:"memberName") as! String
//            print(username)
//            
//            usernameLabel.text =  username
//            
//            
//            //DISPLAY MOBILE NUMBER.
//            let mobileNumber = UserDefaults.standard.object(forKey:"mobileNum") as! String
//            print(mobileNumber)
//            
//            mobile_numberLabel.text =  mobileNumber
//            
//        
//            //DISPLAY TIER LEVEL 
//            let tierlevel = UserDefaults.standard.object(forKey:"level") as! String
//             print(tierlevel)
//            tierLevel.text = tierlevel
//        
//            //DISPLAY BALANCE
//            let blnce = UserDefaults.standard.object(forKey:"blnc") as! String
//            print(blnce)
//            bonuspoints.text = "Points - \(blnce)"
//        
//        
//            //DISPLAY PROFILE IMAGE.
//            let profileImage = UserDefaults.standard.object(forKey:"ProfileImage") as! String
//            print(profileImage)
//        
//            let imagestringApi = profileImage
//            profileImageview.sd_setImage(with: URL(string: imagestringApi), placeholderImage: UIImage(named: "if_icons_user_1564534"))
//            profileImageview.layer.cornerRadius = 30.0
//            profileImageview.clipsToBounds = true
//            profileImageview.isUserInteractionEnabled = true
//            profileImageview.contentMode = .scaleAspectFill
//            
//        
//    
//
//    }
    
    
    //FUNCTION FOR CHECKING MEMBER TYPE.
    func checkMemberType()
    {
        let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
        
        if membertype == "D"
        {
            view1.isHidden = false
            view2.isHidden = false
            view3.isHidden = false
            view4.isHidden = false
            view5.isHidden = false
            
        }
        else if membertype == "R"
        {
            //HIDE THE VIEWS LIST OF RETAILER.
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = true
            view4.isHidden = true
            view5.isHidden = true
            
            
            //CALL THE FUNCTION FOR SHOWING THE LIST VIEWS OF RETAILER.
             self.forRetailer()
        }
        
       
        
    }
    
    //FUNCTION FOR DISPLAYING THE LIST VIEWS FOR REATILER.
    func forRetailer()
    {
        
        //CREATE VIEW 1.
        let firstView = UIView(frame: CGRect(x:11, y:178, width: 300, height: 61))
        firstView.backgroundColor = UIColor.white
        firstView.layer.borderColor = UIColor.lightGray.cgColor
        firstView.layer.borderWidth = 0.5;
        self.view.addSubview(firstView)
        let tapView1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnView3))
        firstView.addGestureRecognizer(tapView1)
        self.scrollview.addSubview(firstView)
        
            //ADD IMAGE IN FIRST VIEW.
            let firstIcon = UIImageView()
            firstIcon.frame = CGRect(x: 24 , y:9, width: 40, height: 40)
            firstIcon.image = UIImage(named: "ic_swipe")
            firstView.addSubview(firstIcon)
        
            //ADD LABEL IN FIRST VIEW.
            let firstLabel = UILabel(frame: CGRect(x:81, y:19, width: 227, height: 21))
            firstLabel.textAlignment = .left
            firstLabel.text = "My Transactions"
            firstLabel.textColor = UIColor(red: 32/255, green: 95/255, blue: 166/255, alpha: 1)
            firstLabel.font = UIFont.boldSystemFont(ofSize: 18)
            firstView.addSubview(firstLabel)
        
        
        //CREATE VIEW 2.
        let secondView = UIView(frame: CGRect(x:11, y:242, width: 300, height: 61))
        secondView.backgroundColor = UIColor.white
        secondView.layer.borderColor = UIColor.lightGray.cgColor
        secondView.layer.borderWidth = 0.5;
        self.view.addSubview(secondView)
        let tapView2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnView4))
        secondView.addGestureRecognizer(tapView2)
        self.scrollview.addSubview(secondView)
        
            //ADD IMAGE IN FIRST VIEW.
            let secondIcon = UIImageView()
            secondIcon.frame = CGRect(x: 24 , y:9, width: 40, height: 40)
            secondIcon.image = UIImage(named: "download-1")
            secondView.addSubview(secondIcon)
            
            //ADD LABEL IN FIRST VIEW.
            let secondLabel = UILabel(frame: CGRect(x:92, y:19, width: 250, height: 21))
            secondLabel.textAlignment = .left
            secondLabel.text = "Redemption"
            secondLabel.textColor = UIColor(red: 32/255, green: 95/255, blue: 166/255, alpha: 1)
            secondLabel.font = UIFont.boldSystemFont(ofSize: 18)
            secondView.addSubview(secondLabel)
        
        
    }
    
    
    
    //GESTURE FUNCTIONs
    func gestureFunctions()
    {
        //TAP ON view 1.
        let tapView1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnView1))
        view1.addGestureRecognizer(tapView1)
        
        //TAP ON view 2.
        let tapView2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnView2))
        view2.addGestureRecognizer(tapView2)
        
        //TAP ON view 3.
        let tapView3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnView3))
        view3.addGestureRecognizer(tapView3)
        
        //TAP ON view 4.
        let tapView4: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnView4))
        view4.addGestureRecognizer(tapView4)
        
        //TAP ON view 5.
        let tapView5: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnView5))
        view5.addGestureRecognizer(tapView5)
    }
    
    
    //GESTURE ACTION FUNCTIONS.
    
    //1
    @objc func tapOnView1()
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllowedBagsScreen") as! AllowedBagsScreen
        self.navigationController?.pushViewController(secondViewController, animated: true)
    
    }
    
    //2
    @objc func tapOnView2()
    {
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddMemberScreen") as! AddMemberScreen
//        self.navigationController?.pushViewController(secondViewController, animated: true)
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountStatementScreen") as! AccountStatementScreen
        secondViewController.userId = self.userID
        secondViewController.fromAllocation = "Yes"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    //3
    @objc func tapOnView3()
    {
        checkViewController = "HomeScreen"
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountStatementScreen") as! AccountStatementScreen
        secondViewController.userId = self.userID
        secondViewController.mobileNUmber = self.mobnumber
        secondViewController.checkViewController = checkViewController
         self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }

    //4
    @objc func tapOnView4()
    {
      let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
        
        if membertype == "D"
        {
           if self.bonuspoints.text == ""
           {
            
            let alert = UIAlertController(title:"", message:"You can not see the Reward catalogue" , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

           }
          else
           {
            checkViewController = "HomeScreen"
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RedeemPointsVC") as! RedeemPointsVC
            secondViewController.checkViewController = checkViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
            }
        }
            
        else if membertype == "R"
        {
            
            if self.bonuspoints.text == ""
            {
                
                let alert = UIAlertController(title:"", message:"You can not see the Reward catalogue" , preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RedemptionsScreen") as! RedemptionsScreen
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }

        }

        
    }

    //5
    @objc func tapOnView5()
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ManageMemberScreen") as! ManageMemberScreen
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //MY PROFILE API.
    func profileApi()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        
        let user = "lakshya"
        let password = "lakshya@001"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }

        
        let postString = "http://jklsky.com/api/Service.svc/ViewDealerProfile"
        
        let newTodo: [String: Any] =  ["UserId": userID] as [String : Any]
        
        print(newTodo)
        
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
                        //SAVE THE PROFILE IMAGE IN USERDEFAULT.
                        UserDefaults.standard.set(profileImage, forKey: "ProfileImage")
                        UserDefaults.standard.synchronize()
                        
                        
                        //TIER LEVEL.
                        let level = response["TierName"].stringValue
                        self.tierlevel.append(level)
                        print(self.tierlevel)
                        
                    }
                    
                    if swiftyJsonVar["ViewDealerProfile"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                       
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
        
        
        let postString = "http://jklsky.com/api/Service.svc/ViewRetailerProfile"
        
        let newTodo: [String: Any] =  ["UserId": userID] as [String : Any]
        
        
        self.showProgress()
        
        Alamofire.request(postString, method: .post, parameters: newTodo,
                          
                          encoding: JSONEncoding.default)
            
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
                        
                    }
                    
                    if swiftyJsonVar["ViewRetailerProfile"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                       
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
    
    
    //HOME API.
    func homeAPI()
    {
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        let user = "lakshya"
        let password = "lakshya@001"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }

        
        let postString = "http://jklsky.com/api/Service.svc/Home"
        
        let newTodo: [String: Any] =  ["UserId": userID] as [String : Any]
        
        
       
        
        Alamofire.request(postString, method: .post, parameters: newTodo,
                          
                          encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON { response in
                
                
                if((response.result.value) != nil)
                {
                    
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    
                    self.error_code = swiftyJsonVar["Home"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                    
                    let result = swiftyJsonVar["Home"]["Result"].stringValue
                    print(result)
                    
                    
                    self.Response = swiftyJsonVar["Home"]["Response"].arrayValue as NSArray
                    print(self.Response)
                    
                    
                    for response in swiftyJsonVar["Home"]["Response"].arrayValue
                    {
                        
                        self.memberName = response["MemberName"].stringValue
                        print(self.memberName)
                        //SAVE THE MEMBER NAME IN USERDEFAULT.
                        UserDefaults.standard.set( self.memberName, forKey: "MemberName")
                        UserDefaults.standard.synchronize()
                    
                        
                        self.profImage = response["ProfileImage"].stringValue
                        print(self.profImage )
                        //SAVE THE PROFILE IMAGE IN USERDEFAULT.
                        UserDefaults.standard.set( self.profImage, forKey: "ProfImage")
                        UserDefaults.standard.synchronize()
                        
                        
                        self.bonusPoints = response["Balance"].stringValue
                        print( self.bonusPoints)
                       
                        
                        self.tiername = response["TierName"].stringValue
                        print(self.tiername)
                        
                        
                        self.mobnumber = response["MobileNumber"].stringValue
                        print(self.mobnumber)
                        //SAVE THE MOBILE NUMBER IN USERDEFAULT.
                        UserDefaults.standard.set(self.mobnumber, forKey: "mobileNumber")
                        UserDefaults.standard.synchronize()
                    }
                    
                    if swiftyJsonVar["Home"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        //self.hideProgress()
                        
                        //DISPLAY MEMBER NAME
                        self.usernameLabel.text = self.memberName
                        
                        
                        //DISPLAY MOBILE NUMBER.
                        self.mobile_numberLabel.text = userID
                        
                        
                        //DISPLAY TIER LEVEL
                        self.tierLevel.text = self.tiername
                        
                        //DISPLAY BALANCE
                        self.bonuspoints.text = "Points - \(self.bonusPoints)"
                       
                        //DISPLAY PROFILE IMAGE.
                        let imagestringApi = self.profImage
                        
                        self.profileImageview.sd_setImage(with: URL(string: imagestringApi), placeholderImage: UIImage(named: "if_icons_user_1564534"))
                        self.profileImageview.layer.cornerRadius = 30.0
                        self.profileImageview.clipsToBounds = true
                        self.profileImageview.isUserInteractionEnabled = true
                        self.profileImageview.contentMode = .scaleAspectFill
                        self.hideProgress()
                    }                    else
                        
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
