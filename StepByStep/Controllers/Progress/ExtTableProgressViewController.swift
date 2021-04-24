//
//  ExtTableProgressViewController.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 24/4/21.
//

import Foundation
import UIKit


extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (stepDataSource?.count)!
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text =  ((stepDataSource![indexPath.row] as AnyObject).object(forKey: "steps") as? String)! 
        cell.detailTextLabel?.text = (stepDataSource![indexPath.row] as AnyObject).object(forKey: "enddate") as? String
        
        cell.textLabel?.font = UIFont(name: "Antonio-Thin", size: 17)
        cell.detailTextLabel?.font = UIFont(name: "Antonio-Thin", size: 17)
        
        return cell
    }
    
}

