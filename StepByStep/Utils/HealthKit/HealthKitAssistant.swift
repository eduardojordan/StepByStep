//
//  HealthKitAssistant.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 24/4/21.
//

import Foundation
import UIKit
import HealthKit


private enum HealthkitSetupError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
}


class HealthKitAssistant {
    
    static let shared = HealthKitAssistant()

    let healthKitStore = HKHealthStore()
    
    func getHealthKitPermission(completion: @escaping (Bool) -> Void) {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        let stepsCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        self.healthKitStore.requestAuthorization(
            toShare:[stepsCount]
            , read:
            [ stepsCount
            ]
            )
        {
            (success, error) in
            if success {
                print("Permission accept.")
                
                completion(true)
                
                
            } else {
                if error != nil {
                    print(error ?? "")
                }
                DispatchQueue.main.async {
                    completion(false)
                }
                print("Permission denied.")
            }
        }
    }
    
    func getMostRecentStep(for sampleType: HKQuantityType, completion: @escaping (_ stepRetrieved: Int, _ stepAll : [[String : String]]) -> Void) {
        
        let mostRecentPredicate =  HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictStartDate)
        
        var interval = DateComponents()
        interval.day = 1
        
        let stepQuery = HKStatisticsCollectionQuery(quantityType: sampleType , quantitySamplePredicate: mostRecentPredicate, options: .cumulativeSum, anchorDate: Date.distantPast, intervalComponents: interval)
        
        stepQuery.initialResultsHandler = { query, results, error in
            
            if error != nil {

                return
            }
            if let myResults = results {
                
                var stepsData : [[String:String]] = [[:]]
                var steps : Int = Int()
                stepsData.removeAll()
                
                myResults.enumerateStatistics(from: Date.distantPast, to: Date()) {
                    
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMM d, yyyy"
                        dateFormatter.locale =  NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
                        dateFormatter.timeZone = NSTimeZone.local
                        
                        var tempDic : [String : String]?
                        let endDate : Date = statistics.endDate
                        
                        steps = Int(quantity.doubleValue(for: HKUnit.count()))
                        
                        tempDic = [
                            "enddate" : "\(dateFormatter.string(from: endDate))",
                            "steps"   : "\(steps)"
                        ]
                        stepsData.append(tempDic!)
                    }
                }
                completion(steps, stepsData.reversed())
            }
        }
        HKHealthStore().execute(stepQuery)
    }
    
    
    
}
