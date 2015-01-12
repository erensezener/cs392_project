//
//  Prediction.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 22/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import Foundation

class Prediction{
    var title: String
    var addDate : NSDate
    var resolutionDate: NSDate
    var confidence: String
    var statementIsTrue: Bool
    var isCompleted: Bool
    var probabilityUpdates = [(String, NSDate)]()
    
    init(title: String, confidence: String, resolutionDate: NSDate){
        self.title = title
        self.addDate = NSDate()
        self.confidence = confidence
        self.resolutionDate = resolutionDate
        self.isCompleted = false
        self.statementIsTrue = false
        self.probabilityUpdates.append((self.confidence, self.addDate))
    }
    
    init(title: String, confidence: String, resolutionDate: NSDate, addDate: NSDate, statementIsTrue: Bool, isCompleted: Bool, probabilityUpdates: [(String, NSDate)]){
        self.title = title
        self.addDate = addDate
        self.confidence = confidence
        self.resolutionDate = resolutionDate
        self.isCompleted = isCompleted
        self.statementIsTrue = statementIsTrue
        self.probabilityUpdates = probabilityUpdates
    }
    
    func dumpAttributes() -> (String, NSDate, String, NSDate, Bool, Bool, [String], [NSDate]){
        var probabilityUpdates0 = [String]()
        var probabilityUpdates1 = [NSDate]()
        
        for p in probabilityUpdates{
            probabilityUpdates0.append(p.0)
            probabilityUpdates1.append(p.1)
        }
        
        return (title, addDate, confidence, resolutionDate, isCompleted, statementIsTrue, probabilityUpdates0, probabilityUpdates1)
    }
    
    func judgePrediction(statementIsTrue : Bool){
        self.isCompleted = true
        self.statementIsTrue = statementIsTrue
    }
    
    func getTruthValue() -> Bool{
        return self.statementIsTrue
    }
    
    func doBayesianUpdate(P_HString: String, P_E_Given_HString: String, P_E_Given_HnotString: String){
        
        self.confidence = self.getPosterior(P_HString, P_E_Given_HString:P_E_Given_HString, P_E_Given_HnotString: P_E_Given_HnotString)
        probabilityUpdates.append((self.confidence, NSDate()))

    }
    
    func getPosterior(P_HString: String, P_E_Given_HString: String, P_E_Given_HnotString: String) -> String{
        let P_H = P_HString.toInt()
        let P_E_Given_H = P_E_Given_HString.toInt()
        let P_E_Given_Hnot = P_E_Given_HnotString.toInt()
        let posterior = P_H! * P_E_Given_H! * 100 / (P_H! * P_E_Given_H! + (100 - P_H!)*P_E_Given_Hnot!)
        let posteriorNSNumber = posterior as NSNumber
        let posteriorString = posteriorNSNumber.stringValue
        
        println("Posterior is " + posteriorString)
        
        return posteriorString
    }
    
    func doRegularUpdate(newConfidence :String){
        println(newConfidence)
        probabilityUpdates.append((newConfidence, NSDate()))
        self.confidence = newConfidence
    }
    
    func getConfidenceString() -> String{
        return confidence
    }
    
    func getUpdateStringAt(index: Int) -> String{
        return probabilityUpdates[index].0
    }
    
    func getUpdateDateAt(index: Int) -> NSDate{
        return probabilityUpdates[index].1
    }
    
    func deleteUpdateAt(index: Int){
        probabilityUpdates.removeAtIndex(index)
    }
    
    func getNumberOfUpdates() -> Int{
        return probabilityUpdates.count
    }
}