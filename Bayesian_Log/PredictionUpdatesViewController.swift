//
//  HistoryViewController.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 03/01/15.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import UIKit

class PredictionUpdatesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var prediction: Prediction?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("confidenceUpdate", object: nil)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prediction!.getNumberOfUpdates()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell") as UITableViewCell
        cell.textLabel?.text = prediction!.getUpdateDateAt(indexPath.item).description //TODO
        cell.detailTextLabel?.text = prediction!.getUpdateStringAt(indexPath.item)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var seeUpdatesRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Updates", handler:{action, indexpath in
            println("See Updates•ACTION");
            
            //TODO implement segue
            
        });
        seeUpdatesRowAction.backgroundColor = UIColor(red: 0.598, green: 0.251, blue: 0.3922, alpha: 1.0);
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            println("DELETE•ACTION");
            self.prediction!.deleteUpdateAt(indexPath.item)
            self.tableView.reloadData()
        });
        
        return [deleteRowAction, seeUpdatesRowAction];
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        println(editingStyle)
        if editingStyle == .Delete {
            prediction?.deleteUpdateAt(indexPath.item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}