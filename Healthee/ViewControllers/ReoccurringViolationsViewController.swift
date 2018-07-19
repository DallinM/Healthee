//
//  ReoccurringViolationsViewController.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/19/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import Foundation

import UIKit

class ReoccurringViolationsViewController: UIViewController {
    
    @IBOutlet weak var firstMostNameViolation: UILabel!
    
    @IBOutlet weak var secondMostNameViolation: UILabel!
    
    @IBOutlet weak var thirdMostViolation: UILabel!
    
    @IBOutlet weak var firstMostNumberViolations: UILabel!
    
    @IBOutlet weak var secondMostNumberViolation: UILabel!
    
    @IBOutlet weak var thirdMostNumberViolation: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    func updateViews() {
        
        firstMostNameViolation.text = "\(String(OverviewModelController.sharedController.firstMostKey))"
        
        firstMostNumberViolations.text = "\(String(OverviewModelController.sharedController.firstMostValue))"
        
        
        
        //MARK: - Second Violation Label
        
        if OverviewModelController.sharedController.secondMostValue == 0 || OverviewModelController.sharedController.secondMostValue == 1 {
            
            secondMostNameViolation.text = "---"
            
        } else {
            secondMostNameViolation.text = "\(String(OverviewModelController.sharedController.secondMostKey))"
            
            secondMostNumberViolation.text = "\(String(OverviewModelController.sharedController.secondMostValue))"
        }
        
        
        //MARK: - Third Display of Violations
        if OverviewModelController.sharedController.thirdMostValue == 0 || OverviewModelController.sharedController.thirdMostValue == 1 {
            
            thirdMostViolation.text = "---"
            
        } else {
            thirdMostViolation.text = "\(String(OverviewModelController.sharedController.thirdMostKey))"
            
            thirdMostNumberViolation.text = "\(String(OverviewModelController.sharedController.thirdMostValue))"
            
        }
    }
    
    
}
