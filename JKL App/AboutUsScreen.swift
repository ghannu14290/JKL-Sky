//
//  AboutUsScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 18/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import MBProgressHUD

class AboutUsScreen: UIViewController,UIWebViewDelegate
{
    //WEBVIEW.
     @IBOutlet var webview: UIWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "About Us"
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
        
        //CALL THE CREATE WEBVIEW FUNC TO DISPLAY THE WEBVIEW ON VIEW.
        self.createWebview()
        
    }
    
    
    //WEBVIEW.
    func createWebview()
    {
        webview.delegate = self
        
        let url = NSURL (string: "http://jklsky.com/MobileApp/Aboutus.htm");
        let requestObj = NSURLRequest(url: url! as URL)
        webview.loadRequest(requestObj as URLRequest);
        
    }
    
    //FUNCTION FOR BACKBUTTON ACTION FROM NAVIGATION BAR
    @objc func back()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftmenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
