//
//  UpdateViewController.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 22/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController{
    var priorProbability :String?
    @IBOutlet weak var confidenceLabel: UILabel! //with % character
    
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        //TODO Do something
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        confidenceLabel.text! = self.priorProbability!
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}