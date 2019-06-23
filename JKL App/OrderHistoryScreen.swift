//
//  OrderHistoryScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 18/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import DatePickerDialog

@available(iOS 10.0, *)
class OrderHistoryScreen: UIViewController
{
    
    //OUTLETS.
    @IBOutlet var fromDate: UIButton!
    @IBOutlet var toDate: UIButton!
    @IBOutlet var fromplchlderLabel: UILabel!
    @IBOutlet var toplchldrLabel: UILabel!
    var fromDateString = String()
    var toDateString = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //NAVIGATION BAR
        self.navigationItem.title = "Redemption History"
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
        
        fromDate.setTitle("", for: .normal)
        toDate.setTitle("", for: .normal)
        
        //SHOW PLACEHOLDERS.
        fromplchlderLabel.isHidden = false
        toplchldrLabel.isHidden = false
        
    }
    
    
    
    
    func chnageBorder()
    {
        //FROM DATE BUTTON.
        fromDate.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        fromDate.layer.borderWidth = 0.5;
        fromDate.layer.cornerRadius = 5.0;
        
        
        //TO DATE BUTTON.
        toDate.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        toDate.layer.borderWidth = 0.5;
        toDate.layer.cornerRadius = 5.0;
        
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
    
   
    //DATEPICKER ACTION fOR FROM DATE.
     @IBAction func fromDateBtn(_ sender: Any)
    {
        
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) { (date) in
            if let dt = date {
                print("\(dt)")
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "dd-MMM-yyyy" //Your New Date format as per requirement change it own
                let newDate = dateFormatter.string(from: date!) //pass Date here
                print(newDate) //New formatted Date string
                self.fromDate.setTitle(newDate, for: .normal)
                self.fromplchlderLabel.isHidden = true
                
                
            }
        }

     
    }

    
    //DATEPICKER ACTION FOR TO DATE.
    @IBAction func todateBtn(_ sender: Any)
    {
        
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) { (date) in
            if let dt = date {
                print("\(dt)")
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "dd-MMM-yyyy" //Your New Date format as per requirement change it own
                let newDate = dateFormatter.string(from: date!) //pass Date here
                print(newDate) //New formatted Date string
                self.toDate.setTitle(newDate, for: .normal)
                self.toplchldrLabel.isHidden = true
            }
        }

    }
    
    
    
    //VALIDATIONS ON BUTTONS.
    
    func areValid() -> Bool
    {
        if fromDate.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select from-date", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if toDate.titleLabel?.text == nil
        {
            let alert = UIAlertController(title: "", message: "Please select to-date", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    
    }
    
    //SUBMIT BUTTON
    @IBAction func submitBtn(_ sender: Any)
    {
        if areValid()
        {
            fromDateString = (fromDate.titleLabel?.text)!
            toDateString = (toDate.titleLabel?.text)!
            
            if fromDateString < toDateString
            {
                print("Success")
                let membertype = UserDefaults.standard.object(forKey:"memberType") as! String
                print(membertype)
                
                if membertype == "D"
                {
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "OrderHistoryTableviewVC") as! OrderHistoryTableviewVC
                    secondViewController.FromString = fromDateString
                    secondViewController.toString = toDateString
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
                    
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "OrderHistoryTableviewVC") as! OrderHistoryTableviewVC
                     secondViewController.FromString = fromDateString
                     secondViewController.toString = toDateString
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
                
            }
                
            else if fromDateString == toDateString
            {
                print("Success")
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "OrderHistoryTableviewVC") as! OrderHistoryTableviewVC
                secondViewController.FromString = fromDateString
                secondViewController.toString = toDateString
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
}
