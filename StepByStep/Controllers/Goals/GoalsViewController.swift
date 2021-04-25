//
//  GoalsViewController.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import UIKit
import Reachability
import CoreData

class GoalsViewController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var goals = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        ReachabilityManager.shared.addObserver(viewController: self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTabBar()
        internetAvailable()

      
    }
    
    func internetAvailable() {
        if !(ReachabilityManager.shared.isReachable()) {
            self.getLocalData()
        } else {
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
            self.getServerData()
        }
    }
    
    func setupNavigationBar() {
        self.title = localizedString("text_goals")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Antonio-Bold", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = Colors.BlueLight
    }
    
    func setupTabBar() {
        self.tabBarItem.title = localizedString("text_goals")
        self.tabBarController?.tabBar.items?[0].image = UIImage(named: "trophyIcon4")
        self.tabBarController?.tabBar.items?[1].image = UIImage(named: "shoeIcon5")
        self.tabBarController?.tabBar.tintColor = Colors.BlueLight
    }
    
    func setupTableView() {
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    func getServerData() {
        Request.shared.getRequest {(result) in
            self.goals.removeAll()
            self.goals.append(contentsOf: result.items)
            DispatchQueue.main.async {
                CoredataManager.shared.saveInLocalData(array: self.goals)
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    func getLocalData() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        CoredataManager.shared.retrieveLocalData(array: self.goals)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.tableView.reloadData()
        }
    }
    
}
