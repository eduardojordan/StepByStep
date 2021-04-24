//
//  ProgressViewController.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import UIKit
import HealthKit


class ProgressViewController: UIViewController {

    @IBOutlet weak var lblStepToday: UILabel!
    @IBOutlet weak var lblSteps: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var todayStep = Int()
    
    var stepDataSource : [[String:String]]? = [] {
        didSet{
            DispatchQueue.main.async {
//               self.activityIndicator.startAnimating()
//               self.activityIndicator.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        HealthKitPermision()
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        self.tableView.isHidden = true
        
  
    }
    
    func setupNavigationBar() {
        self.title = localizedString("text_score")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Antonio-Bold", size: 22)!]
    }
    
    func HealthKitPermision(){
        HealthKitAssistant.shared.getHealthKitPermission { (response) in
            self.loadMostRecentSteps()
        }
    }

    func loadMostRecentSteps()  {
        
        guard let stepsdata = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        HealthKitAssistant.shared.getMostRecentStep(for: stepsdata) { (steps , stepsData) in
            self.todayStep = steps
            self.stepDataSource = stepsData
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.lblStepToday.text = "\(self.todayStep)"
                self.lblStepToday.font  = UIFont(name: "Antonio-Bold", size: 70)
                self.lblSteps.text = "Steps"
                self.lblSteps.font  = UIFont(name: "Antonio-Thin", size: 20)
            }
        }
    }
    

}
