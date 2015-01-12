//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Wei, Mei on 1/10/15.
//  Copyright (c) 2015 Wei, Mei. All rights reserved.
//

import UIKit

class SettingViewController : UIViewController {
    
    
    @IBOutlet weak var tipController: UISegmentedControl!
    @IBOutlet weak var colorSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        let fileManager = (NSFileManager.defaultManager())
        let directorys : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        
        if (directorys != nil){
            let directories:[String] = directorys!;
            let dictionary = directories[0]; //documents directory
            
            
            let plistpath = dictionary.stringByAppendingPathComponent(plistfile);
            
            if fileManager.fileExistsAtPath(plistpath){
                //Reading Plist file
                
                let resultDictionary = NSMutableDictionary(contentsOfFile: plistpath)!
                
                var value: AnyObject? = resultDictionary.valueForKey(key)
                var doubleValue = value?.doubleValue
                
                if doubleValue == tipPercentages[0]
                {
                    tipController.selectedSegmentIndex = 0
                }
                else if doubleValue == tipPercentages[1] {
                    tipController.selectedSegmentIndex = 1
                }
                else {
                    tipController.selectedSegmentIndex = 2
                }
                
                if let colorValue: AnyObject = resultDictionary.valueForKey(colorKey)
                {
                    if (colorValue as NSString == "darkGray")
                    {
                        colorSwitch.setOn((true), animated: false)
                    }
                    else {
                        colorSwitch.setOn((false), animated: false)
                    }
                }
            }
        }
        else {
            println("directory is empty")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onCancelTouchUp(sender: AnyObject) {
    
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    @IBAction func onSaveTouchUp(sender: AnyObject) {
        let fileManager = (NSFileManager.defaultManager())
        let directorys : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        
        if (directorys != nil){
            let directories:[String] = directorys!;
            let dictionary = directories[0]; //documents directory
            
            //  Create and insert the data into the Plist file  ....
            
            var myDictionary:NSMutableDictionary = [key: tipPercentages[tipController.selectedSegmentIndex]]
            if colorSwitch.on {
                myDictionary[colorKey] = "darkGray"
            }
            else {
                myDictionary[colorKey] = "lightGray"
            }
            
            let plistpath = dictionary.stringByAppendingPathComponent(plistfile);
            
            (myDictionary as NSDictionary).writeToFile(plistpath, atomically: false)
            
        }
        else {
            println("directory is empty")
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}
