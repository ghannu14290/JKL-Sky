//
//  StoreAdvertisingScreen.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 18/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON




class StoreAdvertisingScreen: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, MyCampaignProtocol, campNameProtocol
{
    
    //OUTETS.
    @IBOutlet var campaignTypebtn: UIButton!
    @IBOutlet var selectplchldr: UILabel!
    @IBOutlet var imageview1: UIImageView!
    @IBOutlet var imageview3: UIImageView!
    @IBOutlet var imagview2: UIImageView!
    
    //IMAGEPICKER.
    var imagePicker = UIImagePickerController()
    var imagePicked = 0
    
    //DELEGATE VALUE.
    var campIdValue: String?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //NAVIGATION BAR
        self.navigationItem.title = "Store Advertising"
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
        
        //SET THE BORDER COLOR.
        self.change()
        
        
        //GESTURE FUNCTIONs
        self.gestureFunctions()
        
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
    
    
    //PROTOCOL DELEGATE METHOD.
    func campaihName(valueSent: String)
    {
        selectplchldr.isHidden = true
        campaignTypebtn.setTitle(valueSent, for: .normal)
    }
    
    func campaignId(valueSent: String)
    {
        campIdValue = valueSent
    }
    
    //CHANGE BORDER COLOR
    func change()
    {
        //SET THE BORDER COLOR.
        
        //1
        imageview1.layer.borderColor = UIColor.lightGray.cgColor
        imageview1.layer.borderWidth = 0.5;
        
        //2
        imagview2.layer.borderColor = UIColor.lightGray.cgColor
        imagview2.layer.borderWidth = 0.5;
        
        //3
        imageview3.layer.borderColor = UIColor.lightGray.cgColor
        imageview3.layer.borderWidth = 0.5;
        
        
        //4
        campaignTypebtn.layer.borderColor = (UIColor(red: 207/255, green: 208/255, blue: 212/255, alpha: 1).cgColor)
        campaignTypebtn.layer.borderWidth = 0.5;
        campaignTypebtn.layer.cornerRadius = 5.0;
        
    }
    

    @IBAction func campaignType(_ sender: Any)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CampaignTypeVc") as! CampaignTypeVc
        secondViewController.campIdDelegate = self
        secondViewController.campnameDelegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    
    @IBAction func submitbtn(_ sender: Any)
    {
      
      if areValidTextfields()
      {
    
        
        let alert = UIAlertController(title: "", message: "Coming Soon...", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

   //     self.advertisingAPI()
    
       }
        
    }

    func areValidTextfields() -> Bool
    {
            if campaignTypebtn.titleLabel?.text == nil
            {
                let alert = UIAlertController(title: "", message: "Please select type of campaign", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
        return true
    }
    
    
    //GESTURE FUNCTIONs
    func gestureFunctions()
    {
        //TAP ON IMAGEVIEW1.
        let tapImage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnImageview1))
        imageview1.addGestureRecognizer(tapImage)
        
        //TAP ON IMAGEVIEW2.
        let tapImage2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnImageview2))
        imagview2.addGestureRecognizer(tapImage2)
        
        //TAP ON IMAGEVIEW3.
        let tapImage3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnImageview3))
        imageview3.addGestureRecognizer(tapImage3)
    }
    
    
    @objc func tapOnImageview1()
    {
        self.actionsheetmemberImage()
        imagePicked = 1
    }
    
    
    @objc func tapOnImageview2()
    {
        self.actionsheetmemberImage()
        imagePicked = 2
    }
    
    
    @objc func tapOnImageview3()
    {
        self.actionsheetmemberImage()
        imagePicked = 3
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
            imageview1.image = chosenImage
        }
        else if imagePicked == 2
        {
            imagview2.image = chosenImage
        }
        else if imagePicked == 3
        {
            imageview3.image = chosenImage
        }
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //STORE ADVERTISING API
    func advertisingAPI()
    {
        self.showProgress()
        
        //MEMBER ID
        let userId = UserDefaults.standard.object(forKey:"userID") as! String
        print(userId)
        
        //BASE64 IMAGE1.
        let imageData = UIImageJPEGRepresentation(imageview1.image!, 0.1)
        print("BASE 64 \(String(describing: imageData))")
        
        let imageDateString = imageData?.base64EncodedString()
        print("image string \(String(describing: imageDateString))")
        
        
        //BASE64 IMAGE2.
        let imageData2 = UIImageJPEGRepresentation(imagview2.image!, 0.1)
        print("BASE 64 \(String(describing: imageData2))")
        
        let imageDateString2 = imageData2?.base64EncodedString()
        print("image string \(String(describing: imageDateString2))")
        
        //BASE64 IMAGE3.
        let imageData3 = UIImageJPEGRepresentation(imageview3.image!, 0.1)
        print("BASE 64 \(String(describing: imageData3))")
        
        let imageDateString3 = imageData2?.base64EncodedString()
        print("image string \(String(describing: imageDateString3))")
        
        
        let postString = "http://jklsky.com/api/Service.svc/AddStoreAdvertising"
        
        let newTodo: [String: Any] =
            ["UserId":userId,
             "CampaignID":campIdValue!,
             "ImageFileType":"JPEG",
             "Image":imageDateString!,
            "ImageFileType2":"JPEG",
            "Image2":imageDateString2!,
            "ImageFileType3":"JPEG",
            "Image3":imageDateString3!] as [String : Any]
        
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
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    
                    let result = swiftyJsonVar["AddStoreAdvertising"]["Result"].stringValue
                    print(result)
                    
                    
                    if swiftyJsonVar["AddStoreAdvertising"]["Result"].stringValue == "Success"
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
