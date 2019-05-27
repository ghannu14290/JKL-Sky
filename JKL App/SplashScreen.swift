//
//  SplashScreen.swift
//  JKL SKY APP
//
//  Created by Ramandeep Singh Bakshi on 16/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(navigate), userInfo: nil, repeats: false)
        print(timer)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func navigate()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.login()
    }
    
    


}
