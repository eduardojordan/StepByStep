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
        self.internetAvailable()
    }
    
    func internetAvailable() {
        if !(ReachabilityManager.shared.isReachable()) {
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
            self.retrieveLocalData()
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        } else {
            self.activityIndicator.startAnimating()
            self.getServerData()
        }
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
    
    func getServerData() {
        Request.shared.getRequest {(result) in
            self.goals.append(contentsOf: result.items)
            DispatchQueue.main.async {
                self.saveInLocalData(array: self.goals)
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    func isExist(id: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContex = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityGoals")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id )
        let res = try! managedContex.fetch(fetchRequest)
        
        return res.count > 0 ? true : false
    }
    
    func saveInLocalData(array: [Item]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContex = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "EntityGoals", in: managedContex)
        
        for elements in 0..<array.count {
            if !isExist(id: array[elements].id) {
                let user = NSManagedObject(entity: userEntity!, insertInto: managedContex)
                user.setValue(array[elements].id, forKey: "id")
                user.setValue(array[elements].title, forKey: "title")
                user.setValue(array[elements].description, forKey: "descrip")
                user.setValue(array[elements].type, forKey: "type")
                user.setValue(array[elements].reward.trophy, forKey: "trophy")
                user.setValue(array[elements].reward.points, forKey: "points")
                user.setValue(array[elements].goal, forKey: "goal")
            }
        }
        do {
            try managedContex.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    func retrieveLocalData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContex = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityGoals")
        do {
            let result = try managedContex.fetch(fetchRequest)
            self.goals.removeAll()
            for data in result as! [NSManagedObject]  {
                
                self.goals.append(Item(
                                    id: data.value(forKey: "id") as! String,
                                    title: data.value(forKey: "title") as! String,
                                    description: data.value(forKey: "descrip") as! String,
                                    type: data.value(forKey: "type") as! String,
                                    goal: data.value(forKey: "goal") as! Int,
                                    reward: Reward(trophy: data.value(forKey: "trophy") as! String,
                                                   points: data.value(forKey: "points") as! Int))
                )
            }
            print(self.goals)
        } catch {
            print("Failed retrieve Data")
        }
    }
    //
    //
    //    func updateLocalData() {
    //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    //        let managedContex = appDelegate.persistentContainer.viewContext
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityGoals")
    //        fetchRequest.predicate = NSPredicate(format: "xxx = %@", "A")
    //        do {
    //            let test = try managedContex.fetch(fetchRequest)
    //
    //            let objectUpdate = test[0] as! NSManagedObject
    //            objectUpdate.setValue("title", forKey: "")
    //            objectUpdate.setValue("descrip", forKey: "")
    //            objectUpdate.setValue("type", forKey: "")
    //            objectUpdate.setValue("goal", forKey: "")
    //            objectUpdate.setValue("trophy", forKey: "")
    //            objectUpdate.setValue("points", forKey: "")
    //            do {
    //                try managedContex.save()
    //            } catch  {
    //                print(error)
    //            }
    //        } catch {
    //            print("Failed update Data")
    //        }
    //    }
    //
    //
    //
    //    func deleteLocalData() {
    //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    //        let managedContex = appDelegate.persistentContainer.viewContext
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityGoals")
    //        fetchRequest.predicate = NSPredicate(format: "xxx = %@", "A")
    //        do {
    //            let test = try managedContex.fetch(fetchRequest)
    //
    //            let objectDelete = test[0] as! NSManagedObject
    //            managedContex.delete(objectDelete)
    //            do {
    //                try managedContex.save()
    //            } catch  {
    //                print(error)
    //            }
    //        } catch {
    //            print("Failed delete Data")
    //        }
    //    }
    //

    
}
