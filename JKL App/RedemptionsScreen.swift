//
//  RedemptionsScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 17/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import MBProgressHUD


class RedemptionsScreen: UIViewController,UIWebViewDelegate
{
    //WEBVIEW.
    let myWebView:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    override func viewDidLoad()
    {
        super.viewDidLoad()

        //NAVIGATION BAR
        self.navigationItem.title = "Redemption Catalogue"
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
        
        //CALL THE CREATE WEBVIEW FUNC TO DISPLAY THE WEBVIEW ON VIEW.
        self.createWebview()

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
    
 

    //WEBVIEW.
    func createWebview()
    {
        //MOBILENUMBER IN USERDEFAULT.
        let number = UserDefaults.standard.object(forKey:"mobileNum") as! String
        print(number)
    
        //GUID IN USERDEFAULT.
        let guid = UserDefaults.standard.object(forKey:"guid") as! String
        print(guid)

        self.showProgress()
        self.view.addSubview(myWebView)
        myWebView.delegate = self
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                NSLog("\(cookie)")
            }
        }
        
        let storage = HTTPCookieStorage.shared
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        
        
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        let strings =  "http://jklsky.com/MobileApp/default.aspx?guid=\(guid)&Mobileno=\(number)"
        print(strings)
        let url = NSURL (string:strings );
        let requestObj = NSURLRequest(url: url! as URL)
        self.hideProgress()
        myWebView.loadRequest(requestObj as URLRequest);
        
    }
    
    //DELEGATE METHODS OF WEBVIEW
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        self.showProgress()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        self.hideProgress()
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

}
