//
//  ManageMemberScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 18/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit


@available(iOS 10.0, *)
class ManageMemberScreen: UIViewController, UISearchBarDelegate
{
 
    //SEARCHBAR OUTLET.
    @IBOutlet var searchBar: UISearchBar!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
       
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
        backButn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20.0, bottom: 0, right: 13.0)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: backButn), animated: true)
        
        
        //SEARCHBAR.
        searchBar.showsScopeBar = true
        searchBar.delegate = self

        //TAP ON VIEW.
        let tapVIEW: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapVIEW)
        
    }
    
    @objc func dismissKeyboard()
    {
        searchBar.resignFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        //MAKE THE SEARCH BAR BLANK.
        searchBar.text = ""
        
    }
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
        //self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func submitSearchBttn(_ sender: Any)
    {
        searchBar.resignFirstResponder()
       
        //MOBILE NUMEBR IN USERDEFAULT.
        let number = UserDefaults.standard.object(forKey:"mobileNumber") as! String
        print(number)
        
        if searchBar.text != number
        {
            if areValidSearchTextField() && validMobileNumber()
            {
            let searchtext = searchBar.text
            print(searchtext!)
            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewMemberScreen") as! ViewMemberScreen
            secondViewController.searchText = searchtext
            self.navigationController?.pushViewController(secondViewController, animated: true)
                
            }
        }
        else
        {
            let alert = UIAlertController(title: "", message: "Do not enter your mobile number.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            searchBar.text = ""
        }
        
    }
    
    //VALIDATION ON TEXTFIELDS of LOGIN
    func areValidSearchTextField() -> Bool
    {
        if searchBar.text == ""
        {
            let alert = UIAlertController(title: "", message: "Please enter mobile number. It can't be blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
            
        
        return true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        guard let textValue = searchBar.text
            else
        {
            return true
        }
        
        if text.isEmpty {
            return true
        }
        
        let newLength = textValue.characters.count
        return newLength <= 9
    }
    
    //FUNCTION FOR CHECK VALID MOBILE NUMBER.
    func validate(value: String) -> Bool
    {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
        
    }
    
    func validMobileNumber() -> Bool
    {
        if validate(value:searchBar.text!)
        {
            print("Valid Mobile number")
        }
        else
        {
            let alert = UIAlertController(title: "", message: "Please enter valid Mobile number!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return true
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    
}
