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
    
    func removeCompletedPrediction(index: Int){
        completedPredictions.removeAtIndex(index)
    }
    
    func completePrediction(index: Int, truthValue: Bool){
        let p = predictions.removeAtIndex(index)
        p.judgePrediction(truthValue)
        completedPredictions.append(p)
    }
    
    func getNumberOfPredictions() -> Int{
        return predictions.count
    }
    
    func getNumberOfCompletedPredictions() -> Int{
        return completedPredictions.count
    }
    
    func getPredictionAtIndex(index: Int) -> Prediction{
        return predictions[index]
    }
    
    func getCompletedPredictionAtIndex(index: Int) -> Prediction{
        return completedPredictions[index]
    }
    
    func getCompletedConfidenceAtIndex(index: Int) -> String{
        return completedPredictions[index].getConfidenceString()
    }
    
    func getConfidenceAtIndex(index: Int) -> String{
        return predictions[index].getConfidenceString()
    }
    
}