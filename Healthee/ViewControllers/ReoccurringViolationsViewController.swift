//
//  ReoccurringViolationsViewController.swift
//  FirstRoundTest
//
//  Created by Caston  Boyd on 7/17/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

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
        
        firstMostNameViolation.text = "\(String(MapViewController.firstMostKey))"
        firstMostNumberViolations.text = "\(String(MapViewController.firstMostValue))"
        
        //MARK: - Second Violation Label
        
        if MapViewController.secondMostValue == 0 || MapViewController.secondMostValue == 1 {
            secondMostNameViolation.text = "---"
            secondMostNumberViolation.text = "---"
            
        } else {
            secondMostNameViolation.text = "\(String(MapViewController.secondMostKey))"
            secondMostNumberViolation.text = "\(String(MapViewController.secondMostValue))"
        }
        
        
        //MARK: - Third Display of Violations
        if MapViewController.thirdMostValue == 0 || MapViewController.thirdMostValue == 1 {
            thirdMostViolation.text = "---"
            thirdMostNumberViolation.text = "---"
            
        } else {
            thirdMostViolation.text = "\(String(MapViewController.thirdMostKey))"
            thirdMostNumberViolation.text = "\(String(MapViewController.thirdMostValue))"
            
        }
    }
}

