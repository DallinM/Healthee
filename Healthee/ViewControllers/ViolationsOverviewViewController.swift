//
//  ViolationsOverviewViewController.swift
//  FirstRoundTest
//
//  Created by Caston  Boyd on 7/17/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit

class ViolationsOverviewViewController: UIViewController {
    
    @IBOutlet weak var majorViolationsLabel: UILabel!
    @IBOutlet weak var minorViolationsLabel: UILabel!
    
    @IBOutlet weak var dateOfLastInspection: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    func updateViews() {
        
        majorViolationsLabel.text = "\(String(MapViewController.firstDateMajorNumber))"
        
        minorViolationsLabel.text = "\(String(MapViewController.firstDateMinorNumber))"
        dateOfLastInspection.text = "As of \(MapViewController.firstInspectionDate)"
        
    }
    
}
