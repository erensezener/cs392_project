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
    }
    
    
}