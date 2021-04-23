//
//  ExtNSObject.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 23/4/21.
//

import Foundation

extension NSObject {
    var TAG: String {
        return String(describing: type(of: self)) + ": "
    }
}
