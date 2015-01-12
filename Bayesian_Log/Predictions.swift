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
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let userDefaultKey = "predictions"
    
    func load(){
        predictions.removeAll(keepCapacity: false)
        completedPredictions.removeAll(keepCapacity: false)
        
        if let dict: AnyObject = userDefaults.objectForKey(userDefaultKey){
            let dictX: [String:AnyObject] = userDefaults.objectForKey(userDefaultKey) as [String:AnyObject]
            let predictionsX = dictX["predictions"] as [AnyObject]
            let completedPredictionsX = dictX["completedPredictions"] as [AnyObject]
            
            for prediction in predictionsX{
                let p = prediction as [String: AnyObject]
                let title = p["title"] as String
                let addDate = p["addDate"] as NSDate
                let confidence = p["confidence"] as String
                let resolutionDate = p["resolutionDate"] as NSDate
                let statementIsTrue = p["statementIsTrue"] as Bool
                let isCompleted = p["isCompleted"] as Bool
                
                let probabilityUpdates0 = p["probabilityUpdates0"] as [AnyObject]
                let probabilityUpdates1 = p["probabilityUpdates1"] as [AnyObject]
                var probabilityUpdates = [(String, NSDate)]()
                
                for i in 0...probabilityUpdates0.count - 1 {
                    let tuple = (probabilityUpdates0[i] as String, probabilityUpdates1[i] as NSDate)
                    probabilityUpdates.insert(tuple, atIndex: 0)
//                    probabilityUpdates.append(tuple)
                }
                
                let currentPrediction = Prediction(title: title, confidence: confidence, resolutionDate: resolutionDate, addDate: addDate, statementIsTrue: statementIsTrue, isCompleted: isCompleted, probabilityUpdates: probabilityUpdates)
                
                predictions.insert(currentPrediction, atIndex: 0)

            }
            
            for prediction in completedPredictionsX{
                let p = prediction as [String: AnyObject]
                let title = p["title"] as String
                let addDate = p["addDate"] as NSDate
                let confidence = p["confidence"] as String
                let resolutionDate = p["resolutionDate"] as NSDate
                let statementIsTrue = p["statementIsTrue"] as Bool
                let isCompleted = p["isCompleted"] as Bool
                
                let probabilityUpdates0 = p["probabilityUpdates0"] as [AnyObject]
                let probabilityUpdates1 = p["probabilityUpdates1"] as [AnyObject]
                var probabilityUpdates = [(String, NSDate)]()
                
                for i in 0...probabilityUpdates0.count - 1 {
                    let tuple = (probabilityUpdates0[i] as String, probabilityUpdates1[i] as NSDate)
                    probabilityUpdates.insert(tuple, atIndex: 0)
//                    probabilityUpdates.append(tuple)
                }
                
                let currentPrediction = Prediction(title: title, confidence: confidence, resolutionDate: resolutionDate, addDate: addDate, statementIsTrue: statementIsTrue, isCompleted: isCompleted, probabilityUpdates: probabilityUpdates)
                
                completedPredictions.insert(currentPrediction, atIndex: 0)
                
            }
        }
        
        println("loaded data")
        
    }
    
    func save(){
        
        var predictionsToSave = [[String: AnyObject]]()
        var completedPredictionsToSave = [[String: AnyObject]]()
        
        for prediction in predictions{
            var predictionDict = [String: AnyObject]()
            var attributeDump = prediction.dumpAttributes()
            predictionDict["title"] = attributeDump.0
            predictionDict["addDate"] = attributeDump.1
            predictionDict["confidence"] = attributeDump.2
            predictionDict["resolutionDate"] = attributeDump.3
            predictionDict["isCompleted"] = attributeDump.4
            predictionDict["statementIsTrue"] = attributeDump.5
            predictionDict["probabilityUpdates0"] = attributeDump.6
            predictionDict["probabilityUpdates1"] = attributeDump.7
//            predictionsToSave.append(predictionDict)
            predictionsToSave.insert(predictionDict, atIndex: 0)
            println("Saving P " + (predictionDict["title"] as String) )

        }
        
        for completedPrediction in completedPredictions{
            var predictionDict = [String: AnyObject]()
            var attributeDump = completedPrediction.dumpAttributes()
            predictionDict["title"] = attributeDump.0
            predictionDict["addDate"] = attributeDump.1
            predictionDict["confidence"] = attributeDump.2
            predictionDict["resolutionDate"] = attributeDump.3
            predictionDict["isCompleted"] = attributeDump.4
            predictionDict["statementIsTrue"] = attributeDump.5
            predictionDict["probabilityUpdates0"] = attributeDump.6
            predictionDict["probabilityUpdates1"] = attributeDump.7
//            completedPredictionsToSave.append(predictionDict)
            completedPredictionsToSave.insert(predictionDict, atIndex: 0)
            println("Saving CP " + (predictionDict["title"] as String) )
            
        }
        
        var dictionary = ["predictions": predictionsToSave]
        dictionary["completedPredictions"] = completedPredictionsToSave
        userDefaults.setObject(dictionary, forKey: userDefaultKey)
        
        userDefaults.synchronize()
        println("saved data")
        
    }
    
    func addPrediction(title: String, confidence: String, resolutionDate: NSDate){
        predictions.append(Prediction(title: title, confidence: confidence, resolutionDate: resolutionDate))
        save()
    }
    
    func removePrediction(index: Int){
        predictions.removeAtIndex(index)
        save()
    }
    
    func removeCompletedPrediction(index: Int){
        completedPredictions.removeAtIndex(index)
        save()
    }
    
    func completePrediction(index: Int, truthValue: Bool){
        let p = self.getPredictionAtIndex(index)
        self.removePrediction(index)
        p.judgePrediction(truthValue)
        completedPredictions.append(p)
        save()
        
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