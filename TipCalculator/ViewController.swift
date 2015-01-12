//
//  ViewController.swift
//  TipCalculator
//
//  Created by Wei, Mei on 1/10/15.
//  Copyright (c) 2015 Wei, Mei. All rights reserved.
//

import UIKit

var tipPercentages = [0.18, 0.2, 0.22]
let plistfile = "settings.plist"
let key = "tipPercentage"
let colorKey = "themeColor"

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipController: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }

    override func viewWillAppear(animated: Bool) {
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
                        view.backgroundColor = UIColor.darkGrayColor()
                    }
                    else {
                        view.backgroundColor = UIColor.lightGrayColor()
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

    @IBAction func onEditingChanged(sender: AnyObject) {
        var billAmount = (billField.text as NSString).doubleValue
        
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipController.selectedSegmentIndex]
        var tip = billAmount * tipPercentage
        
        var total = billAmount + tip
     
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }

    @IBAction func onTap(sender: AnyObject) {
        billField.resignFirstResponder()
       // view.endEditing(true)
    }
}

