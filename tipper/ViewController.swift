//
//  ViewController.swift
//  tipper
//
//  Created by Dhruv Upadhyay on 12/12/15.
//  Copyright © 2015 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tipLabel: UILabel!
    
    @IBOutlet var billField: UITextField!
    
    @IBOutlet var totalLabel: UILabel!
    
    @IBOutlet var tipControl: UISegmentedControl!
    
    @IBOutlet var onePerson: UILabel!
    
    @IBOutlet var twoPerson: UILabel!
    
      
    @IBOutlet var fourPerson: UILabel!
    @IBOutlet var threePerson: UILabel!
    
    @IBOutlet var fivePerson: UILabel!
    
    //Put the variable here since u will be reusing them throughout this view
    var doubleValue: Double?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    //This func takes in the changes from segmented control only
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        defaults.setDouble(tipPercentage, forKey: "TipPercent")
        
        //Tip result will change realtime
        loadTipResult()
    }
    
    //This func takes in the changes from bill textfield changes only
    @IBAction func billAmountChanged(sender: UITextField) {
        
        loadTipResult()
        
    }
    
    //Main func that does the calculation
    func loadTipResult() {
        
        //Load the value from NSUserdefault
        doubleValue = defaults.doubleForKey("TipPercent")
        
        //you can use if billAmount = Double(billField.text) { //the rest of the code here } too but guard statement is powerful in here to reduce loads of code and its safe so you don't have to unwrap the optionals on billAmount
        guard let billAmount = Double(billField.text!) else { return }//NSString(string: billField.text!).doubleValue
        
        //Just for safety check
        if doubleValue != nil {
            
            

            let tip = billAmount * doubleValue! //doubleValue is forcefully unwrap since you are sure that it exist with that if statement
            let total = billAmount + tip
            
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
            onePerson.text = String(format: "$%.2f", total)
            twoPerson.text = String(format: "$%.2f", total/2)
            threePerson.text = String(format: "$%.2f", total/3)
            fourPerson.text = String(format: "$%.2f", total/4)
            fivePerson.text = String(format: "$%.2f", total/5)
        
        } else {
            
            tipLabel.text = String(format: "$%.2f", 0.0)
            totalLabel.text = String(format: "$%.2f", 0.0)
        }
        
    }
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        billField.text = ""
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        doubleValue = defaults.doubleForKey("TipPercent")
        
        //Making sure that the setting here takes in whatever was already in the NSUserDefaults
        if doubleValue == 0.18 {
            tipControl.selectedSegmentIndex = 0
        } else if doubleValue == 0.20 {
            tipControl.selectedSegmentIndex = 1
        } else if doubleValue == 0.22 {
            tipControl.selectedSegmentIndex = 2
        }
        
        loadTipResult()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onTap(sender: AnyObject) {
         
        view.endEditing(true)
        
        
    }

    
    

}

