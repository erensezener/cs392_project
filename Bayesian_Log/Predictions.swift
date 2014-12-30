//
//  Predictions.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 22/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import Foundation

class Predictions{
    var predictions = [Prediction]()
    var completedPredictions = [Prediction]()
    
    func addPrediction(title: String, confidence: String, resolutionDate: NSDate){
        predictions.append(Prediction(title: title, confidence: confidence, resolutionDate: resolutionDate))
    }
    
    
    func removePrediction(index: Int){
        predictions.removeAtIndex(index)
    }
    
    func completePrediction(index: Int){
        let p = predictions.removeAtIndex(index)
        completedPredictions.append(p)
    }
    
    func getNumberOfPredictions() -> Int{
        return predictions.count
    }
    
    func getPredictionAtIndex(index: Int) -> Prediction{
        return predictions[index]
    }
    
    func getConfidenceAtIndex(index: Int) -> String{
        return predictions[index].getConfidenceString()
    }
}