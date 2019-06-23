//
//  AccountStatementScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 18/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import DatePickerDialog


@available(iOS 10.0, *)
class AccountStatementScreen: UIViewController, valueProtocol
{
    
    //OUTLETS
    @IBOutlet var fromDate: UILabel!
    @IBOutlet var todate: UILabel!
    @IBOutlet var accountstatmnt: UIButton!
    @IBOutlet var fromDateBtn: UIButton!
    @IBOutlet var todatebutton: UIButton!
    var fromDateString = String()
    var toDateString = String()
    var checkViewController: String! = "leftmenu"
    var fromDat = Date()
    var toDat = Date()
    //VALUES FROM PREVIOS VIEW.
    var userId = String()
    var mobileNUmber = String()
    var memberTypeFromManageMmber = String()
    var fromAllocation = String()
   override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //PRINT VALUES OF PREVIOUS VIEWCONTROLLER.
        print("userID of the member \(userId)")
        print("mobilenumber of the member \(mobileNUmber)")
        
        
        //NAVIGATION BAR
        if fromAllocation == "Yes"
        {
            self.navigationItem.title = "Allocation Date Range"

        }
        else
        {
        self.navigationItem.title = "Account Statement"
        }
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
    
        
        //CALL THE FUNCTION FOR SETTING THE BUTTON'S BORDER COLOR
        self.chnageBorder()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        fromDateBtn.setTitle("", for: .normal)
        todatebutton.setTitle("", for: .normal)
        
        //SHOW PLACEHOLDERS.
        fromDate.isHidden = false
        todate.isHidden = false
        
    }
    
    
    //DELEGATE METHOD
    func viewValue(valueSent: String)
    {
        checkViewController = valueSent
    }
    
    
    //CHANGE BORDER.
    func chnageBorder()
    {
        //FROM DATE BUTTON.
        fromDateBtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        fromDateBtn.layer.borderWidth = 0.5;
        fromDateBtn.layer.cornerRadius = 5.0;
        
        
        //TO DATE BUTTON.
        todatebutton.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        todatebutton.layer.borderWidth = 0.5;
        todatebutton.layer.cornerRadius = 5.0;
        
    }
    
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        if checkViewController == "leftmenu"
        {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
        }
            
        else
        {
        self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //BUTTON ACTIONS.
    @IBAction func accountStatmntBtn(_ sender: Any)
    {
       
        
        if areValid()
        {
            fromDateString = (fromDateBtn.titleLabel?.text)!
            toDateString = (todatebutton.titleLabel?.text)!
            
            if fromDat < toDat
            {
                print("Success")
                let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
                print(membertype)
                
                if fromAllocation == "Yes"
                {
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllocationHistoryVC") as! AllocationHistoryVC
                    
                    secondViewController.FromString = fromDateString
                    secondViewController.toString = toDateString
                    secondViewController.userId = userId
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
                else{
                
                if membertype == "D"
                {
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyTransactionsScreen") as! MyTransactionsScreen
                    
                    secondViewController.FromString = fromDateString
                    secondViewController.toString = toDateString
                    secondViewController.userId = userId
                    secondViewController.mobileNUmber = mobileNUmber
                    secondViewController.checkViewController = checkViewController
                    secondViewController.checkMemberType = memberTypeFromManageMmber
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                    
                }
                else if membertype == "R"
                {
                    
                    //MEMBER NAME
                    let userid = UserDefaults.standard.object(forKey:"userID") as! String
                    print(userid)
                    
                    //MOBILE NUMBER
                    let mobileNumber = UserDefaults.standard.object(forKey:"mobileNum") as! String
                    print(mobileNumber)
                    
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyTransactionsScreen") as! MyTransactionsScreen
                    
                    secondViewController.FromString = fromDateString
                    secondViewController.toString = toDateString
                    secondViewController.userId = userid
                    secondViewController.mobileNUmber = mobileNumber
                    secondViewController.checkViewController = checkViewController
                    secondViewController.checkMemberType = memberTypeFromManageMmber
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                    
                }
                }
            }
                
            else if fromDat == toDat
            {
                print("Success")
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyTransactionsScreen") as! MyTransactionsScreen
                secondViewController.FromString = fromDateString
                secondViewController.toString = toDateString
                secondViewController.userId = userId
                secondViewController.mobileNUmber = mobileNUmber
                secondViewController.checkViewController = checkViewController
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
                
            else
            {
                print("error")
                let alert = UIAlertController(title:"", message:"Not required, to-date can not be less than from-date", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func fromDateAction(_ sender: Any)
    {
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date)
        { (date) in
            if let dt = date {
                print("\(dt)")
                self.fromDat = date!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MMM-yyyy" //Your New Date format as per requirement change it own
                let newDate = dateFormatter.string(from: date!) //pass Date here
                
                
                print(newDate) //New formatted Date string
                self.fromDateBtn.setTitle(newDate, for: .normal)
                
                self.fromDate.isHidden = true
              
                
            }
        }
 
    }
    
    
    @IBAction func todateAction(_ sender: Any)
    {
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) { (date) in
            if let dt = date {
                print("\(dt)")
                self.toDat = date!
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "dd-MMM-yyyy" //Your New Date format as per requirement change it own
                let newDate = dateFormatter.string(from: date!) //pass Date here
                print(newDate) //New formatted Date string
                self.todatebutton.setTitle(newDate, for: .normal)
                self.todate.isHidden = true
            }
        }
    }
    
    //VALIDATIONS ON BUTTONS.
     func areValid() -> Bool
    {
        
        
        if fromDateBtn.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select from-date", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if todatebutton.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select to-date", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }

        
        
        return true
        
    }
    


}
