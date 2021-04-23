//
//  GoalsViewController.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import UIKit
import Reachability

class GoalsViewController: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var tableView: UITableView!

    var goals = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGoalsData()
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        self.title = localizedString("text_goals")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Antonio-Bold", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black
        
    }
    
    func setupTableView() {
        tableView.rowHeight = 110
        tableView.separatorStyle = .none
    }
    
    func getGoalsData() {
        Request.shared.getRequest { [self] (result) in
            goals.append(contentsOf: result.items)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
          
        }
    }
    
//    if ReachabilityManager
//
//
//if !(ReachabilityManager.shared.isReachable()) {
//    print("")
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        let notNetViewcontroller = storyboard.instantiateViewController(withIdentifier: "NotConectionNetViewController")
////        self.navigationController!.pushViewController(notNetViewcontroller, animated: true)
//    }

}
