//
//  UpdateViewController.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 22/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController{
    weak var prediction: Prediction?
    
    @IBOutlet weak var P_H: UITextField!
    @IBOutlet weak var P_E_given_H: UITextField!
    @IBOutlet weak var P_E_given_Hnot: UITextField!
    @IBOutlet weak var P_H_given_E: UITextField!
    @IBOutlet weak var newConfidence: UITextField!
    @IBOutlet weak var confidenceLabel: UILabel! //with % character
    
    
    func updateConfidenceLabel(){
        confidenceLabel.text! = prediction!.getConfidenceString()
        P_H.text! = prediction!.getConfidenceString()
    }
    
    func clearConditionals(){
        P_E_given_H.text = ""
        P_E_given_Hnot.text = ""
        P_H_given_E.text = ""
    }
    
    @IBAction func calculateButtonPressed(sender: AnyObject) {
        let P_H_string = P_H.text
        let P_E_given_H_string = P_E_given_H.text
        let P_E_given_Hnot_string = P_E_given_Hnot.text
        
        let P_H_given_E_string = prediction!.getPosterior(P_H_string, P_E_Given_HString: P_E_given_H_string, P_E_Given_HnotString: P_E_given_Hnot_string)
        
        P_H_given_E.text = P_H_given_E_string
        super.viewDidLoad()
        
        
//        let P_H_given_E_string = P_H_given_E.text
        
    }
    
    
    @IBAction func commitButtonPressed(sender: AnyObject) {
        let P_H_string = P_H.text
        let P_E_given_H_string = P_E_given_H.text
        let P_E_given_Hnot_string = P_E_given_Hnot.text
        
        let P_H_given_E_string = prediction!.getPosterior(P_H_string, P_E_Given_HString: P_E_given_H_string, P_E_Given_HnotString: P_E_given_Hnot_string)
        
        P_H_given_E.text = P_H_given_E_string
        
        prediction!.doBayesianUpdate(P_H_string, P_E_Given_HString: P_E_given_H_string, P_E_Given_HnotString: P_E_given_Hnot_string)
        
        updateConfidenceLabel()
        clearConditionals()
        
        super.viewDidLoad()
        
    }
    
    @IBAction func regularCommitButtonPressed(sender: AnyObject) {
        prediction!.doRegularUpdate(newConfidence.text!)
        updateConfidenceLabel()
        clearConditionals()
        super.viewDidLoad()
    }
    
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        //TODO Do something
        dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
    }
    

    
    
    override func viewDidLoad() {
        updateConfidenceLabel()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}