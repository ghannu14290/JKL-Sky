//
//  LeftMenuScreen.swift
//  JKL SKY APP
//
//  Created by Ramandeep Singh Bakshi on 16/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import QuartzCore


//PROTOCOL.
protocol valueProtocol
{
    func viewValue(valueSent: String)
    
}


class LeftMenuScreen: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    //OUTLETS.
    @IBOutlet var leftTableview: UITableView!
      var retrailerMenuArray = NSArray()
      var dealerMenuArray = NSArray()
      var imageArray = NSArray()
      var retailerImageArray = NSArray()
      var checkViewController: String!
    
    //DELEGATE VALUE
    var valueOfView:valueProtocol?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //REGISTER TABLEVIEW CELL AND SET THE TABLEVIEW DELEGATE AND DATASOURCE.
        leftTableview.delegate      =   self
        leftTableview.dataSource    =   self
        leftTableview.register(UITableViewCell.self, forCellReuseIdentifier: "LeftMenuTableViewCell")
        let viewBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        
        view.backgroundColor = UIColor(red: 32/255, green: 95/255, blue: 166/255, alpha: 1)
        self.view.addSubview(viewBackground)
        //CALL FUNCTION FOR DISPLAYING THE ARRAY.
        self.addObjectToArray()

        
    }
    
    
    //FUNCTION FOR ADD THE OBJECTS IN ARRAYS.
    func addObjectToArray()
    {
        dealerMenuArray=["","Home","My Profile","Manage Your Member","Allocation History","Account Statement", "Redemption History","Redeem Your Points", "Store Advertising", "About Us", "FAQs", "Contact Us", "Terms and Conditions", "Change Password", "Logout"]
        
        retrailerMenuArray=["","Home","My Profile","Add Transaction","Account Statement","Redemption History","Redemptions", "Store Advertising", "About Us", "FAQs", "Contact Us", "Terms and Conditions", "Change Password", "Logout"]
        
        imageArray = ["","HomeScreen'","userProfile","ManageMember","allocrevised","ic_swipe","orderhistory","download-1", "advrtising", "AboutUs", "FAQs", "ContactUs", "download (2)", "changepsswd", "Logout"]
        
        retailerImageArray = ["","HomeScreen'","userProfile","account_statemnt","ic_swipe","orderhistory","download-1", "advrtising", "AboutUs", "FAQs", "ContactUs", "download (2)", "changepsswd", "Logout"]
    }
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //HIDE NAVIGATION BAR.
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    
    //DELEGATE METHODS OF TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        //SET THE DISPLAY VALUES ACCORDING TO REATILER AND DEALER.
        let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
        
      if membertype == "D"
        {
           return dealerMenuArray.count
            
        }
        else if membertype == "R"
        {
          return retrailerMenuArray.count
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "LeftMenuTableViewCell")
        
        
        
        //SET THE CELL TEXT ACCORDING TO REATILER AND DEALER.
        let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
        
        if indexPath.row == 0
        {
             cell.backgroundColor = UIColor(red: 32/255, green: 95/255, blue: 166/255, alpha: 1)
             cell.selectionStyle = .none
        
            //DISPLAY PROFILE IMAGE.
            let profileImage = UserDefaults.standard.object(forKey:"ProfImage") as! String
            print(profileImage)
            
            let profileImageview = UIImageView()
            let imagestringApi = profileImage
            
            if !imagestringApi.isEmpty {
            
            profileImageview.sd_setImage(with: URL(string: imagestringApi), placeholderImage: UIImage(named: "bg_profile_default"))
            }else{
                profileImageview.image = UIImage(named: "bg_profile_default")
            }
            
            profileImageview.layer.borderColor = UIColor.clear.cgColor
            profileImageview.layer.borderWidth = 1.0;
            profileImageview.layer.cornerRadius = 30.0
            profileImageview.clipsToBounds = true
            profileImageview.isUserInteractionEnabled = true
            profileImageview.contentMode = .scaleAspectFill
            profileImageview.frame = CGRect(x: 20, y: 30, width: 60, height: 60)
            cell.contentView.addSubview(profileImageview)
            

            //DISPLAY USERANEME.
            let username = UserDefaults.standard.object(forKey:"MemberName") as! String
            print(username)
            
            let name = UILabel(frame: CGRect(x: 22, y: 90 , width: self.view.frame.size.width - 44 , height: 30))
            name.textAlignment = .left
            name.text = username
            name.textColor=UIColor.white
            name.font = UIFont.boldSystemFont(ofSize: 14)
            cell.contentView.addSubview(name)
     
            
            //DISPLAY MOBILE NUMBER.
            let mobileNumber = UserDefaults.standard.object(forKey:"mobileNumber") as! String
            print(mobileNumber)
            
            let number = UILabel(frame: CGRect(x: 22, y: 110, width: 250, height: 30))
            number.textAlignment = .left
            number.text = mobileNumber
            number.textColor=UIColor.white
            number.font = UIFont.boldSystemFont(ofSize: 12)
            cell.contentView.addSubview(number)
            
            
        }
      
        else
        {
            cell.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
            
            if membertype == "D"
            {
                let menu = UILabel()
                menu.frame = CGRect(x: 40, y: 11, width: 150, height: 20)
                menu.textAlignment = .left
                menu.text = dealerMenuArray [indexPath.row] as? String
                menu.textColor=UIColor.black
                menu.font = UIFont.systemFont(ofSize: 12)
                cell.contentView.addSubview(menu)
               
                
                let cellImg : UIImageView = UIImageView(frame: CGRect(x: 8, y: 10, width: 25, height: 25))
                cellImg.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                cellImg.image = UIImage(named: imageArray[indexPath.row] as! String)
                cell.contentView.addSubview(cellImg)
    
            }
            else if membertype == "R"
            {
                let menu = UILabel()
                menu.frame = CGRect(x: 40, y: 11, width: 150, height: 20)
                menu.textAlignment = .left
                menu.text = retrailerMenuArray[indexPath.row] as? String
                menu.textColor=UIColor.black
                menu.font = UIFont.systemFont(ofSize: 12)
                cell.contentView.addSubview(menu)
                
                
                let cellImg : UIImageView = UIImageView(frame: CGRect(x: 8, y: 10, width: 25, height: 25))
                cellImg.image = UIImage(named: retailerImageArray[indexPath.row] as! String)
                cellImg.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                cell.contentView.addSubview(cellImg)
            }
        }

        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var r = CGFloat()
        
        if indexPath.row == 0
        {
            r = 150
            
        }
        else
        {
            r = 40
    
        }
        
        
       return r
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //SET THE CELL TEXT ACCORDING TO REATILER AND DEALER.
        let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
        print(membertype)
        
            
        if membertype == "D"
        {
        //MOVE TO HOME.
        if indexPath.row == 1
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.leftmenu()
        }

        //MOVE TO MY PROFILE.
        if indexPath.row == 2
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProfileScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }

        //MOVE TO MANAGE YOUR MEMBER.
        if indexPath.row == 3
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageMemberScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }
        
        //MOVE TO ADD MEMBER.
        if indexPath.row == 4

        {
//            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddMemberScreen") as UIViewController
//            let navigationController = UINavigationController(rootViewController: mainController)
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.menuController .setRoot(navigationController, animated: true)
            
            let userID = UserDefaults.standard.object(forKey:"userID") as! String
            print(userID)

            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountStatementScreen") as! AccountStatementScreen
            secondViewController.userId = userID
            secondViewController.fromAllocation = "Yes"
                        let navigationController = UINavigationController(rootViewController: secondViewController)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.menuController .setRoot(navigationController, animated: true)

            
        }
            
        //MOVE TO ORDER HISTORY.
        if indexPath.row == 5
        {
            checkViewController = "leftmenu"
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountStatementScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            valueOfView?.viewValue(valueSent: checkViewController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
            
        }
            
        //MOVE TO ORDER HISTORY.
        if indexPath.row == 6
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderHistoryScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }
    
        //MOVE TO REDEMPTIONS.
        if indexPath.row == 7
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RedeemPointsVC") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }
            
        
        //MOVE TO STORE ADVERTISING.
        if indexPath.row == 8
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreAdvertisingScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }
            
        
        //MOVE TO ABOUT US.
        if indexPath.row == 9
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutUsScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }
        
        //MOVE TO FAQs.
        if indexPath.row == 10
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FAQScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }
        
        //MOVE TO CONTACT US.
        if indexPath.row == 11
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactUsScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }
        
        //MOVE TO TERMS AND CONDITIONS.
        if indexPath.row == 12
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TandCScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }
        
        
        //MOVE TO CHNAGE PASSWORD.
        if indexPath.row == 13
        {
            let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "changePasswordScreen") as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.menuController .setRoot(navigationController, animated: true)
        }
        
        //LOGOUT
        if indexPath.row == 14
        {
            print("logout Successfull!!");
            
            let prefs = UserDefaults.standard
            let user_id = prefs.string(forKey:"userID")
            prefs.removeObject(forKey:"userID")
            print(user_id!)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.login()
        }
        
        }
        
        if membertype == "R"
        {
            //MOVE TO HOME.
            if indexPath.row == 1
            {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.leftmenu()
            }
            
            //MOVE TO MY PROFILE.
            if indexPath.row == 2
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProfileScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            //MOVE TO ADD TRANSACTION SCREEN.
            if indexPath.row == 3
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTransactionScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            //MOVE TO ACCOUNT STATETMENT.
            if indexPath.row == 4
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountStatementScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
//            
//            //MOVE TO MANAGE YOUR MEMBER.
//            if indexPath.row == 3
//            {
//                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageMemberScreen") as UIViewController
//                let navigationController = UINavigationController(rootViewController: mainController)
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.menuController .setRoot(navigationController, animated: true)
//            }
//            
//            //MOVE TO ADD MEMBER.
//            if indexPath.row == 4
//                
//            {
//                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddMemberScreen") as UIViewController
//                let navigationController = UINavigationController(rootViewController: mainController)
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.menuController .setRoot(navigationController, animated: true)
//                
//            }
            
            //MOVE TO ORDER HISTORY.
            if indexPath.row == 5
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderHistoryScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            //MOVE TO REDEMPTIONS.
            if indexPath.row == 6
            {
               let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RedemptionsScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            
            //MOVE TO STORE ADVERTISING.
            if indexPath.row == 7
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreAdvertisingScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            
            //MOVE TO ABOUT US.
            if indexPath.row == 8
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutUsScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            //MOVE TO FAQs.
            if indexPath.row == 9
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FAQScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            //MOVE TO CONTACT US.
            if indexPath.row == 10
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactUsScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            //MOVE TO TERMS AND CONDITIONS.
            if indexPath.row == 11
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TandCScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            
            //MOVE TO CHNAGE PASSWORD.
            if indexPath.row == 12
            {
                let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "changePasswordScreen") as UIViewController
                let navigationController = UINavigationController(rootViewController: mainController)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.menuController .setRoot(navigationController, animated: true)
            }
            
            //LOGOUT
            if indexPath.row == 13
            {
                print("logout Successfull!!");
                
                let prefs = UserDefaults.standard
                let user_id = prefs.string(forKey:"userID")
                prefs.removeObject(forKey:"userID")
                print(user_id!)
                UserDefaults.standard.removeObject(forKey: "sitetypeid")
                UserDefaults.standard.removeObject(forKey: "userID")

                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
            }

        
          
     
        
    }
}

}
