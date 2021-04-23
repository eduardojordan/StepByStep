//
//  ProgressViewController.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import UIKit

class ProgressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
  
    }
    func setupNavigationBar() {
        self.title = localizedString("text_score")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Antonio-Bold", size: 22)!]
    }
   

}
