//
//  AddPredictionController.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 22/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

//TODO Empty field check
//TODO Confidence only gets two characters

import UIKit

class AddPredictionController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    weak var predictions: Predictions!
    var targetDay = NSDate()
    
    @IBOutlet weak var titleFormField: UITextField!
    @IBOutlet weak var confidenceFormField: UITextField!
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        println("done button presssed")
        println("confidence " + confidenceFormField.text)
        predictions?.addPrediction(titleFormField.text, confidence: confidenceFormField.text, resolutionDate: self.targetDay)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    let timeOptions = ["Today", "Tomorrow", "This week", "In two weeks", "In a month", "In three months", "In six months", "In a year",
    "In two years", "In three years"]
    
    let timeOptionsInDays = [0,1,7,14,31,31*3,31*6,365,365*2,365*3]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return timeOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let today = NSDate()
        let targetDay = NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitDay,
            value: timeOptionsInDays[row],
            toDate: today,
            options: NSCalendarOptions(0))
        
        NSLog("Selected " + targetDay!.description)
        self.targetDay = targetDay!
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}