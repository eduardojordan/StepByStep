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
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTabBar()
        setupInitialLoad()
        HealthKitPermision()
    
    }
    
    func setupNavigationBar() {
        self.title = localizedString("text_score")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Antonio-Bold", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = Colors.BlueLight
    }
    
    func setupTabBar() {
        self.tabBarItem.title = localizedString("text_score")
        self.tabBarController?.tabBar.items?[0].image = UIImage(named: "trophyIcon4")
        self.tabBarController?.tabBar.items?[1].image = UIImage(named: "shoeIcon5")
        self.tabBarController?.tabBar.tintColor = Colors.BlueLight
    }
    
    func setupInitialLoad() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        self.tableView.isHidden = true
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
                self.lblSteps.text = localizedString("text_score")
                self.lblSteps.font  = UIFont(name: "Antonio-Thin", size: 20)
            }
        }
    }
    
    
}
