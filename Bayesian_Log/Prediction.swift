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