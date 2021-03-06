//
//  HistoryViewController.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 31/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    weak var predictions: Predictions?
    var indexToUpdate:Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions!.getNumberOfCompletedPredictions()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell") as UITableViewCell
        let prediction = predictions!.getCompletedPredictionAtIndex(indexPath.item)
        println("History view showing " + prediction.title)
        cell.textLabel?.text = prediction.title
        cell.detailTextLabel?.text = prediction.getConfidenceString()
        if prediction.statementIsTrue{
            cell.detailTextLabel?.textColor = UIColor.greenColor()
        } else {
            cell.detailTextLabel?.textColor = UIColor.redColor()
        }
        return cell
    }
    
    override func viewDidLoad() {
        println("viewDidLoad is called")
        predictions!.load()
        super.viewDidLoad()
        self.tableView.reloadData()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"confidenceUpdate", object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadList(notification: NSNotification){
        //load data here
        predictions!.load()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var seeUpdatesRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Updates", handler:{action, indexpath in
            println("See Updates•ACTION");
            self.indexToUpdate = indexPath.item
            self.performSegueWithIdentifier("updateDetailsSegue", sender: self)
            
            //TODO implement segue

        });
        seeUpdatesRowAction.backgroundColor = UIColor(red: 0.598, green: 0.251, blue: 0.3922, alpha: 1.0);
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            println("DELETE•ACTION");
            self.predictions!.removeCompletedPrediction(indexPath.item)
            self.tableView.reloadData()
        });
        
        return [deleteRowAction, seeUpdatesRowAction];
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    //TODO this is probably redundant
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        println(editingStyle)
        if editingStyle == .Delete {
            predictions!.predictions.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.indexToUpdate = indexPath.item
        self.performSegueWithIdentifier("updateDetailsSegue", sender: self)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        predictions!.load()
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as PredictionUpdatesViewController
        destinationVC.prediction = predictions!.getCompletedPredictionAtIndex(indexToUpdate!)
    }
}