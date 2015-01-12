//
//  TestPredictions.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 22/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import Foundation

class TestPredictions : Predictions{
    var loadHardCodedData = false
    
    let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
        .CalendarUnitDay,
        value: 1,
        toDate: NSDate(),
        options: NSCalendarOptions(0))
    
    func populatePredictions(){
        if loadHardCodedData{
            self.addPrediction("I will be admitted to Gatech", confidence: "20", resolutionDate: tomorrow!)
            self.addPrediction("TRY/USD will reach 2.40", confidence: "70", resolutionDate: tomorrow!)
            self.addPrediction("iPhone7 will have the same size with the 6", confidence: "75", resolutionDate: tomorrow!)
            self.addPrediction("This will be published in App Store", confidence: "10", resolutionDate: tomorrow!)
            self.addPrediction("I will be able to finish this project", confidence: "80", resolutionDate: tomorrow!)
            
            self.addPrediction("Ozyegin will be cancelled today", confidence: "70", resolutionDate: tomorrow!)
            self.addPrediction("It will snow this morning", confidence: "80", resolutionDate: tomorrow!)
            self.getPredictionAtIndex(6).doRegularUpdate("60")
            self.addPrediction("My Mac's problem is due to its graphic card", confidence: "40", resolutionDate: tomorrow!)
            self.getPredictionAtIndex(6).doRegularUpdate("50")
            self.completePrediction(5, truthValue: false)
            self.completePrediction(5, truthValue: true)
            self.completePrediction(5, truthValue: false)
        } else {
            load()
        }
    }
    
    
}