//
//  ViolationsOverviewViewController.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/19/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
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
        
        majorViolationsLabel.text = "\(String(OverviewModelController.sharedController.firstDateMajorNumber))"
        
        minorViolationsLabel.text = "\(String(OverviewModelController.sharedController.firstDateMinorNumber))"
        dateOfLastInspection.text = "As of \(OverviewModelController.sharedController.firstInspectionDate)"
        
    }
    
}

