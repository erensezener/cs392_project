//
//  TestPredictions.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 22/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import Foundation

class TestPredictions : Predictions{
    func populatePredictions(){
        self.addPrediction("I will be admitted to USC", confidence: "50")
        self.addPrediction("TRY/USD will reach 2.40", confidence: "70")
        self.addPrediction("This will be published in App Store", confidence: "40")
        
        
        if let moc = self.managedObjectContext {
            
            LogItem.createInManagedObjectContext(moc,
                title: "1st Item",
                text: "This is my first log item")
            
            LogItem.createInManagedObjectContext(moc,
                title: "2nd Item",
                text: "This is my second log item")
            
            LogItem.createInManagedObjectContext(moc,
                title: "3rd Item",
                text: "This is my third log item")
            
            LogItem.createInManagedObjectContext(moc,
                title: "4th Item",
                text: "This is my fourth log item")
            
            LogItem.createInManagedObjectContext(moc,
                title: "5th Item",
                text: "This is my fifth log item")
            
            LogItem.createInManagedObjectContext(moc,
                title: "6th Item",
                text: "This is my sixth log item")
            
        }
    }
    
    
    
    
}