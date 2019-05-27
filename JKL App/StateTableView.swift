//
//  StateTableView.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 22/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit



//PROTOCOL.
protocol MyProtocol
{
    func stateName(valueSent: String)
    
}


class StateTableView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    //OUTLETS
    @IBOutlet var stateTableView: UITableView!
    
    //VALUES OF TABLEVIEW.
    var states = ["Uttar Pradesh","Haryana","Delhi","Jaipur"]

    //DELEAGTE METHOD.
    var delegate:MyProtocol?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //NAVIGATION BAR
        self.navigationItem.title = "Select State"
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 28/255, green: 118/255, blue: 184/255, alpha: 1)
        
        
        
        //BACKBUTTON ON NAVIGATION BAR.
        let backButn: UIButton = UIButton()
        backButn.setImage(UIImage(named: "ic_action_back (1)"), for: .normal)
        backButn.frame = CGRect(x: 0,y: 0,width: 30,height: 30)
        backButn.addTarget(self, action: #selector(back), for:.touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: backButn), animated: true)
        
        
        
        //TABLEVIEW
        stateTableView.delegate      =   self
        stateTableView.dataSource    =   self
        stateTableView.register(UITableViewCell.self, forCellReuseIdentifier: "stateTableviewcell")
       

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
       
    }
    
    //TABLEVIEW DELEGATE AND DATASOURCE METHODS.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return states.count
            
    
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "stateTableviewcell")
        
        cell.textLabel?.text = states[indexPath.row]
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        print(cell)
        let str: String = (cell.textLabel?.text)!
        print(str)
        
        //MOVE TO ADD MEMBER SCREEN.
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddMemberScreen") as! AddMemberScreen
        secondViewController.stateValue = str
        delegate?.stateName(valueSent: str)
        self.navigationController?.popViewController(animated: true)
        
    }
    


    

}
