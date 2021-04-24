////
////  HealthKitManager.swift
////  StepByStep
////
////  Created by Eduardo Jordan on 24/4/21.
////
//
//import Foundation
//import UIKit
//import HealthKit
//
//
//class HealthKitManager {
//    
//    let healthStore = HKHealthStore()
//    
//    func authorizedHealthKit() -> Bool {
//        var isEnable = true
//        
//        if HKHealthStore.isHealthDataAvailable() {
//            let stepsCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount))
//        }
//        healthStore.requestAuthorization(toShare: nil, read: stepsCount as! Set<HKObjectType>) { (success, error) -> Void in
//            isEnable = success
//        }
//        
//    }
//    
//   
//    }
//    
//}
