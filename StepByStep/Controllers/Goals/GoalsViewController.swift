//
//  GoalsViewController.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import UIKit

class GoalsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
