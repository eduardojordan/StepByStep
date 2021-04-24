//
//  CellTableViewCell.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import UIKit

class CellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblGoal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        self.lblTitle.font = UIFont(name: "Antonio-Bold", size: 22)
        self.lblGoal.font = UIFont(name: "Antonio-Bold", size: 25)
        self.lblType.font = UIFont(name: "Antonio-Thin", size: 12)
        self.lblDescription.font = UIFont(name: "Antonio-Thin", size: 12)
        
        self.lblTitle.textColor = .black
        self.lblGoal.textColor = .black
        self.lblType.textColor = .black
        self.lblDescription.textColor = .black
        
        self.selectionStyle = .none
           
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
