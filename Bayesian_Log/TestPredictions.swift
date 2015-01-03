//
//  TestPredictions.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 22/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import Foundation

class TestPredictions : Predictions{
    let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
        .CalendarUnitDay,
        value: 1,
        toDate: NSDate(),
        options: NSCalendarOptions(0))
    
    func populatePredictions(){
        self.addPrediction("I will be admitted to USC", confidence: "50", resolutionDate: tomorrow!)
        self.addPrediction("TRY/USD will reach 2.40", confidence: "70", resolutionDate: tomorrow!)
        self.addPrediction("This will be published in App Store", confidence: "40", resolutionDate: tomorrow!)
        self.addPrediction("I will be able to finish this project", confidence: "80", resolutionDate: tomorrow!)
        self.completePrediction(2, truthValue: true)
        self.completePrediction(2, truthValue: false)
    }
    
    
}