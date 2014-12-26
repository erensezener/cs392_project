//
//  Prediction.swift
//  Bayesian_Log
//
//  Created by Eren Sezener on 22/12/14.
//  Copyright (c) 2014 Eren Sezener. All rights reserved.
//

import Foundation

class Prediction{
    var title: String?
    var addDate : NSDate?
    var resolutionDate: NSDate?
    var confidence: String?
    var isCompleted: Bool?
    var statementIsTrue: Bool?
    var probabilityUpdates = [String]()
    
    init(title: String, confidence: String){
        self.title = title
        self.confidence = confidence
    }
    
    init(title: String, resolutionDate: NSDate, confidence: String){
        self.title = title
        self.addDate = NSDate()
        println(self.addDate)
        self.confidence = confidence
    }
    
    func judgePrediction(statementIsTrue : Bool){
        self.isCompleted! = true
        self.statementIsTrue = statementIsTrue
    }
    
    func getTruthValue() -> Bool{
        return self.statementIsTrue!
    }
    
    func doBayesianUpdate(P_HString: String, P_E_Given_HString: String, P_E_Given_HnotString: String){
        
        self.confidence = self.getPosterior(P_HString, P_E_Given_HString:P_E_Given_HString, P_E_Given_HnotString: P_E_Given_HnotString)
        probabilityUpdates.append(confidence!)

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
        probabilityUpdates.append(confidence!)
        self.confidence = newConfidence
    }
    
    func getConfidenceString() -> String{
//        let confNSNumber = self.confidence! as NSNumber
//        return confNSNumber.stringValue + "%"
        return confidence!
    }
//    
//    init(title: String, resolutionDate: NSDate, resolutionDate: NSDate, confidence: Int){
//        
//    }
}