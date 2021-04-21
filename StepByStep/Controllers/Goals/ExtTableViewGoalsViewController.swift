//
//  ExtTableViewGoalsViewController.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import Foundation
import UIKit

extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6//goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetail", for: indexPath) //as? CellTableViewCell
        cell.textLabel?.text = "Hola"//goals[indexPath.row].items[0].title
        cell.textLabel?.font = UIFont(name: "Antonio-Medium", size: 18)
        
        return cell
    }
    
}
