//
//  ViewController.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import UIKit

class ViewController: UIViewController {

    var goals = [Goals]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductInfo() 
    }

    func getProductInfo() {
        Request.shared.getRequest { [self] (result) in
            goals.append(result)
            print(goals)
    
        }
    }
}
