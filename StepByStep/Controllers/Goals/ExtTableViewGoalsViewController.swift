//
//  ExtTableViewGoalsViewController.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import Foundation
import UIKit

extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetail", for: indexPath) as? CellTableViewCell
               
        cell!.lblTitle.text = goals[indexPath.row].title
        cell!.lblDescription.text = goals[indexPath.row].description
        cell!.lblType.text = goals[indexPath.row].type.replacingOccurrences(of: "_", with: " ")
        cell!.lblGoal.text = String(goals[indexPath.row].goal)
        
        return cell!
    }
    
}
