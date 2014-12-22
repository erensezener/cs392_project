//
//  ViewController.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 21/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

//TODO hold statistics

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let predictions = TestPredictions()
//    let predictions = Predictions()
    
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions.getNumberOfPredictions()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PredictionCell") as UITableViewCell
        let prediction = predictions.getPredictionAtIndex(indexPath.item)
        cell.textLabel?.text = prediction.title
        cell.detailTextLabel?.text = prediction.getConfidenceString()
        return cell
    }
    
    override func viewDidLoad() {
        predictions.populatePredictions()
        super.viewDidLoad()
        self.tableView.reloadData()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier{
            if identifier == "addPrediction" {
                let destinationVC = segue.destinationViewController as AddPredictionController
                destinationVC.predictions = self.predictions
            }
            else if identifier == "showStatistics" {
//                let destinationVC = segue.destinationViewController as StatisticsViewController
                
            }
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var judgeRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Judge", handler:{action, indexpath in
            println("JUDGE•ACTION");
            
            
            var alertController = UIAlertController(title: "Judge your predictions", message: "Was the statement in your prediction correct?", preferredStyle: .Alert)
            
            // Create the actions
            var yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                
                //TODO
                self.predictions.predictions.removeAtIndex(indexPath.item)
                self.tableView.reloadData()
                
            }
            var noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
                
                //TODO
                self.predictions.predictions.removeAtIndex(indexPath.item)
                self.tableView.reloadData()
            }
            
            // Add the actions
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        });
        judgeRowAction.backgroundColor = UIColor(red: 0.598, green: 0.251, blue: 0.3922, alpha: 1.0);
        
        var updateRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Update", handler:{action, indexpath in
            self.performSegueWithIdentifier("updateSegue", sender: self)
        });
        updateRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            println("DELETE•ACTION");
            self.predictions.predictions.removeAtIndex(indexPath.item)
            self.tableView.reloadData()
        });
        
        return [deleteRowAction, updateRowAction, judgeRowAction];
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        println(editingStyle)
        if editingStyle == .Delete {
            predictions.predictions.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

