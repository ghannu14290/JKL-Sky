//
//  ViewMemberScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 21/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD


class ViewMemberScreen: UIViewController, UITableViewDelegate, UITableViewDataSource
{
  
    
    //OUTLETS.
    @IBOutlet var tableview: UITableView!
   
    var searchText:String!
    var error_code : Int = 0
    var Response = NSArray()
    var userId = [String]()
    var memberType = [String]()
    var firmName = [String]()
    var firstName = [String]()
    var lastName = [String]()
    var mobileNumber = [String]()
    var emailId = [String]()
    var gender = [String]()
    var dob = [String]()
    var address1 = [String]()
    var address2 = [String]()
    var state = [String]()
    var district = [String]()
    var idProofImage = [String]()
    var profileImage =  [String]()
    var currentBalnc = [String]()
    var guid = [String]()
    var stateId = [String]()
    var districtId = [String]()
    
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
    var memberguid = String()
    var memberstateId = String()
    var memberDistrictId = String()
    var checkViewController: String!
    var firmNamePre = String()
    var membertypeToSend = String()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        //PRINT THE SEARCH TEXT.
        print("Search Text is \(searchText)")
        
        //CALL THE API FUNCTION.
        self.viewMember()
        
        
        //NAVIGATION BAR
        self.navigationItem.title = "View Member"
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
        
        
        //CALL DELEGATE AND DATASOURCE METHODS.
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        self.navigationController?.popViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    //DELEGATE AND DATASOURCE METHODS OF TABLEVIEW.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return firstName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "commentViewcell")
        
        
        cell.backgroundView = UIImageView(image: UIImage(named: "ios_block_new"))
        cell.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        

        
        let fisrtString = firstName[indexPath.row]
        let secondString = lastName[indexPath.row]
        let nameString = "\(fisrtString) \(secondString)"
        UserDefaults.standard.set(nameString, forKey: "nameString")
        UserDefaults.standard.synchronize()
        
        let memberName = UILabel(frame: CGRect(x: 16, y:22, width: 300, height: 20))
        memberName.textAlignment = .left
        memberName.text = nameString
        memberName.textColor=UIColor.darkGray
        memberName.font=UIFont.boldSystemFont(ofSize: 16)
        cell.contentView.addSubview(memberName)
        
        
        //MEMBER TYPE
        let memberType = UILabel(frame: CGRect(x: 16, y:45, width: 300, height: 20))
        memberType.textAlignment = .left
        memberType.text = "Member Type : \(self.memberType[indexPath.row])"
        memberType.textColor=UIColor.darkGray
        memberType.font=UIFont.systemFont(ofSize: 12)
        cell.contentView.addSubview(memberType)
        
        
        //MOBILE NUMBER
        let mobile = UILabel(frame: CGRect(x: 16, y:66, width: 300, height: 20))
        mobile.textAlignment = .left
        mobile.text = "Mobile : +91 - \(self.mobileNumber[indexPath.row])"
        mobile.textColor=UIColor.darkGray
        mobile.font=UIFont.systemFont(ofSize: 12)
        cell.contentView.addSubview(mobile)
      
        
        //STATE
        let state = UILabel(frame: CGRect(x: 16, y:87, width: 150, height: 20))
        state.textAlignment = .left
        state.text = "State : \(self.state[indexPath.row])"
        state.textColor=UIColor.darkGray
        state.font=UIFont.systemFont(ofSize: 12)
        cell.contentView.addSubview(state)
        
        
        //DISTRICT
        let district = UILabel(frame: CGRect(x: 150, y:87, width: 200, height: 20))
        district.textAlignment = .left
        district.text = "District : \(self.district[indexPath.row])"
        district.textColor=UIColor.darkGray
        district.font=UIFont.systemFont(ofSize: 12)
        cell.contentView.addSubview(district)
      
        
        //THREE DOTS BUTTON.
        let threeDotsBTN   = UIButton(type: UIButtonType.custom) as UIButton
        threeDotsBTN.frame = CGRect(x:280, y:22, width: 30, height: 30)
        let threeDotsBTNImage = UIImage(named: "ic_action_setting1") as UIImage?
        threeDotsBTN.setBackgroundImage(threeDotsBTNImage, for:.normal)
        threeDotsBTN.addTarget(self, action: #selector(popUpView), for: UIControlEvents.touchUpInside)
        threeDotsBTN.tag = indexPath.row
        cell.contentView.addSubview(threeDotsBTN)
        
        
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        //USERID
        let userid = self.userId[indexPath.row]
        self.memberUserId = userid
        print(memberUserId)
        
        //MOBILE NUMBER
        let number = self.mobileNumber[indexPath.row]
        self.membermobileNumber = number
        print(membermobileNumber)
        
        
        //NAME
        let fisrtString = firstName[indexPath.row]
        let secondString = lastName[indexPath.row]
        let nameString = "\(fisrtString) \(secondString)"
        self.memberName = nameString
        print(memberName)
        
        
        //TYPE
        let type = self.memberType[indexPath.row]
        self.membertype = type
        print(memberType)
        
        //BALANCE
        let blnc = self.currentBalnc[indexPath.row]
        self.balance = blnc
        print(balance)
        
        
        //FIRMNAME
        let cmpny = self.firmName[indexPath.row]
        self.membercomapnyName = cmpny
        print(cmpny)
        
        
        //FIRSTNAME
        let firstname = self.firstName[indexPath.row]
        self.memberfirstName = firstname
        print(firstname)
        
        
        //LASTNAME
        let lastname = self.lastName[indexPath.row]
        self.memberLastname = lastname
        print(lastname)
        
        //LASTNAME
        let emailID = self.emailId[indexPath.row]
        self.memberEmailId = emailID
        print(lastname)
        
        
        //GENDER
        let Gender = self.gender[indexPath.row]
        self.membergender = Gender
        print(Gender)
        
        //DOB
        let dateOfB = self.dob[indexPath.row]
        self.memberdob = dateOfB
        print(dateOfB)
        
        //STATE
        let mState = self.state[indexPath.row]
        self.memberState = mState
        print(mState)
        
        //DISTRICT
        let mdistrict = self.district[indexPath.row]
        self.memberDistrict = mdistrict
        print(mdistrict)
        
        //PROFILEIMAGE
        let proImage = self.profileImage[indexPath.row]
        self.memberprofileImage = proImage
        print(proImage)
        
        //IDPROOFIMAGE
        let IDproofImage = self.idProofImage[indexPath.row]
        self.memberidProofImage = IDproofImage
        print(IDproofImage)
        
        
        //ADDRESS
        let addr = self.address1[indexPath.row]
        self.memberaddress = addr
        print(addr)
        
        //GUID
        let GUID = self.guid[indexPath.row]
        self.memberguid = GUID
        print(GUID)
        
        
        //STATE ID
        let stateId = self.stateId[indexPath.row]
        self.memberstateId = stateId
        
        
        //DISTRICT ID
        let disctId = self.districtId[indexPath.row]
        self.memberDistrictId = disctId
        
        
        self.showpopActionSheet()
    }
    
    
    //THREEDOTS BUTTON ACTION.
    
    @objc func popUpView(sender: UIButton!)
     {
//        
//        //USERID
//        let userid = self.userId[sender.tag]
//        self.memberUserId = userid
//        print(memberUserId)
//        
//        //MOBILE NUMBER
//        let number = self.mobileNumber[sender.tag]
//        self.membermobileNumber = number
//        print(membermobileNumber)
//        
//
//        //NAME
//        let fisrtString = firstName[sender.tag]
//        let secondString = lastName[sender.tag]
//        let nameString = "\(fisrtString) \(secondString)"
//        self.memberName = nameString
//        print(memberName)
//        
//        
//        //TYPE
//        let type = self.memberType[sender.tag]
//        self.membertype = type
//        print(memberType)
//        
//        //BALANCE
//        let blnc = self.currentBalnc[sender.tag]
//        self.balance = blnc
//        print(balance)
//        
//        
//        //FIRMNAME
//        let cmpny = self.firmName[sender.tag]
//        self.membercomapnyName = cmpny
//        print(cmpny)
//        
//        
//        //FIRSTNAME
//        let firstname = self.firstName[sender.tag]
//        self.memberfirstName = firstname
//        print(firstname)
//        
//        
//        //LASTNAME
//        let lastname = self.lastName[sender.tag]
//        self.memberLastname = lastname
//        print(lastname)
//        
//        //LASTNAME
//        let emailID = self.emailId[sender.tag]
//        self.memberEmailId = emailID
//        print(lastname)
//        
//        
//        //GENDER
//        let Gender = self.gender[sender.tag]
//        self.membergender = Gender
//        print(Gender)
//        
//        //DOB
//        let dateOfB = self.dob[sender.tag]
//        self.memberdob = dateOfB
//        print(dateOfB)
//        
//        //STATE
//        let mState = self.state[sender.tag]
//        self.memberState = mState
//        print(mState)
//        
//        //DISTRICT
//        let mdistrict = self.district[sender.tag]
//        self.memberDistrict = mdistrict
//        print(mdistrict)
//        
//        //PROFILEIMAGE
//        let proImage = self.profileImage[sender.tag]
//        self.memberprofileImage = proImage
//        print(proImage)
//        
//        //IDPROOFIMAGE
//        let IDproofImage = self.idProofImage[sender.tag]
//        self.memberidProofImage = IDproofImage
//        print(IDproofImage)
//        
//        
//        //ADDRESS
//        let addr = self.address1[sender.tag]
//        self.memberaddress = addr
//        print(addr)
//        
//        
//        //GUID
//        let GUID = self.guid[sender.tag]
//        self.memberguid = GUID
//        print(GUID)
//        
//        
//        //STATE ID
//        let stateId = self.stateId[sender.tag]
//        self.memberstateId = stateId
//        
//        
//        //DISTRICT ID
//        let disctId = self.districtId[sender.tag]
//        self.memberDistrictId = disctId
//        
//
//        self.showpopActionSheet()
     }
    
    func showpopActionSheet()
    {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Update Member", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.updateMember()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Add Transaction", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.Addtransaction()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Redeem Points", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.redeemPoints()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Account Statement", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.accountStatement()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    //ACTION SHEET ACTION FUNCTIONs.
    func updateMember()
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewMemberVC") as! UpdateViewMemberVC
       
        //FOR PASSING THE VALUE TO NEXT VIEWCONTROLLER.
        secondViewController.memberUserId = memberUserId
        secondViewController.membermobileNumber = membermobileNumber
        secondViewController.memberName = memberName
        secondViewController.membertype = membertype
        secondViewController.balance = balance
        secondViewController.membercomapnyName = membercomapnyName
        secondViewController.memberfirstName = memberfirstName
        secondViewController.memberLastname = memberLastname
        secondViewController.memberEmailId = memberEmailId
        secondViewController.membergender = membergender
        secondViewController.memberdob = memberdob
        secondViewController.memberState = memberState
        secondViewController.memberDistrict = memberDistrict
        secondViewController.memberprofileImage = memberprofileImage
        secondViewController.memberidProofImage = memberidProofImage
        secondViewController.memberaddress = memberaddress
        secondViewController.Idstate = memberstateId
        secondViewController.firmNameFrom = firmNamePre
        print(memberstateId)
        secondViewController.IdDistrict = memberDistrictId
        print(memberDistrictId)
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    func Addtransaction()
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddTransactionScreen") as! AddTransactionScreen
        secondViewController.memberUserId = memberUserId
        secondViewController.membermobileNumber = membermobileNumber
        secondViewController.memberName = memberName
        secondViewController.memberType = membertype
        secondViewController.balance = balance
       self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    func redeemPoints()
    {
        
        checkViewController = "ViewMember"
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RedeemPointsMemberVC") as! RedeemPointsMemberVC
        secondViewController.membermobileNumber = membermobileNumber
        secondViewController.memberguid = memberguid
        secondViewController.membertype = membertype
        secondViewController.checkViewController = checkViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }

    func accountStatement()
    {
        checkViewController = "ViewMember"
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountStatementScreen") as! AccountStatementScreen
        secondViewController.userId = memberUserId
        secondViewController.mobileNUmber = membermobileNumber
        secondViewController.memberTypeFromManageMmber = membertypeToSend
        secondViewController.checkViewController = checkViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
      
    }
    
    

    //VIEWMEMBER API.
    func viewMember()
    {
        let user = "lakshya"
        let password = "lakshya@001"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        //USERID IN USERDEFAULT.
        let userID = UserDefaults.standard.object(forKey:"userID") as! String
        print(userID)
        
        let postString = "http://jklsky.com/api/Service.svc/ViewMember"
        
        let newTodo: [String: Any] =  ["UserId": userID,
                                       "SearchText": searchText] as [String : Any]
        
        print(newTodo)
        
        self.showProgress()
        
        Alamofire.request(postString, method: .post, parameters: newTodo,
                          
                          encoding: JSONEncoding.default, headers:headers)
            
            .responseJSON { response in
                
                if((response.result.value) != nil)
                {
                    self.hideProgress()
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    
                    self.error_code = swiftyJsonVar["ViewMember"]["ErrorCode"].intValue
                    print(self.error_code)
                    
                    let result = swiftyJsonVar["ViewMember"]["Result"].stringValue
                    print(result)
                    
                    
                    self.Response = swiftyJsonVar["ViewMember"]["Response"].arrayValue as NSArray
                    print(self.Response)
                    
                    for response in swiftyJsonVar["ViewMember"]["Response"].arrayValue
                    {
                        
                        //USERID
                        let userID = response["UserId"].stringValue
                        self.userId.append(userID)
                        print(self.userId)
                        
                        //MEMBER TYPE.
                        let memberType = response["MemberType"].stringValue
                        self.membertypeToSend = response["MemberType"].stringValue
                        self.memberType.append(memberType)
                        print(self.memberType)
                        
                        
                        //FIRM NAME.
                        let firmname = response["FirmName"].stringValue
                        self.firmName.append(firmname)
                        print(self.firmName)
                        
                        
                        //FISRT NAME.
                        let firstname = response["FirstName"].stringValue
                        self.firstName.append(firstname)
                        print(self.firstName)
                        
                        
                        //LAST NAME.
                        let lastname = response["LastName"].stringValue
                        self.lastName.append(lastname)
                        print(self.lastName)
                        
                        
                        //MOBILE NUMBER.
                        let mobilenumber = response["MobileNumber"].stringValue
                        self.mobileNumber.append(mobilenumber)
                        print(self.mobileNumber)
                        
                        
                        //EMAIL ID.
                        let emailid = response["EmailId"].stringValue
                        self.emailId.append(emailid)
                        print(self.emailId)
                        
                        
                        //GENDER.
                        let gender = response["Gender"].stringValue
                        self.gender.append(gender)
                        print(self.gender)
                        
                        
                        //DOB.
                        let dOfb = response["DateofBirth"].stringValue
                        self.dob.append(dOfb)
                        print(self.dob)
                        
                        
                        
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
                        self.state.append(state)
                        print(self.state)
                        
                        
                        //DISTRICT.
                        let district = response["District"].stringValue
                        self.district.append(district)
                        print(self.district)
                        
                        
                        //PROFILE IMAGE.
                        let profileImage = response["ProfileImage"].stringValue
                        self.profileImage.append(profileImage)
                        print(self.profileImage)
                        
                        
                        //ID PROOF IMAGE.
                        let idProof = response["IdProofImage"].stringValue
                        self.idProofImage.append(idProof)
                        print(self.idProofImage)
                        
                        
                        //CURRENT BALANCE.
                        let blnc = response["CurrentBalance"].stringValue
                        self.currentBalnc.append(blnc)
                        print(self.currentBalnc)
                        
                        
                        //GUID.
                        let guID = response["CustomerGuid"].stringValue
                        self.guid.append(guID)
                        print(self.guid)
                        
                        
                        //STATE ID.
                        let stateid = response["StateID"].stringValue
                        self.stateId.append(stateid)
                        print(self.stateId)
                        
                        //DISTRICT ID.
                        let distId = response["DistrictID"].stringValue
                        self.districtId.append(distId)
                        print(self.districtId)
                        
                        let firmName1 = response["FirmName"].stringValue
                        self.firmNamePre.append(firmName1)
                        print(self.firmNamePre)

                    }
                    
                    if swiftyJsonVar["ViewMember"]["Result"].stringValue == "Success"
                    {
                        print ("Success")
                        self.hideProgress()
                        self.tableview.reloadData()
                        
                    }
                        
                    else
                    {
                        self.hideProgress()
                        //SHOW ALERT
                        let alert = UIAlertController(title:"", message:result , preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { action in
                            
                            //MOVE TO HOME SCREEN
                            //let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! HomeScreen
                            //self.navigationController?.pushViewController(secondViewController, animated: true)
                            //let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            //appDelegate.leftmenu()
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                    
                }
                
                
        }
        
        
    }
    
    

 
}
