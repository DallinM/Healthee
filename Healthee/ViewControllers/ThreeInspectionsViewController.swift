//
//  ThreeInspectionsViewController.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/19/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import UIKit

class ThreeInspectionsViewController: UIViewController {
    
    //MARK: - Inspection date labels
    @IBOutlet weak var firstRecentInspectionDateLabel: UILabel!
    @IBOutlet weak var secondRecentInspectionDateLabel: UILabel!
    @IBOutlet weak var thirdRecentInspectionDateLabel: UILabel!
    
    
    //MARK: - Major and Minor Violation Labels
    @IBOutlet weak var firstRecentMajorViolationLabel: UILabel!
    @IBOutlet weak var firstRecentMinorViolationLabel: UILabel!
    @IBOutlet weak var secondRecentMajorViolationLabel: UILabel!
    @IBOutlet weak var secondRecentMinorViolationLabel: UILabel!
    @IBOutlet weak var thirdRecentMajorViolationLabel: UILabel!
    @IBOutlet weak var thirdRecentMinorViolationLabel: UILabel!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    func updateViews() {
        
        //MARK: - latest, most recent inspection date is first
        
        firstRecentInspectionDateLabel.text = "\(String(OverviewModelController.sharedController.firstInspectionDate))"
        firstRecentMajorViolationLabel.text = " Major: \(String(OverviewModelController.sharedController.firstDateMajorNumber))"
        firstRecentMinorViolationLabel.text = "Minor: \(String(OverviewModelController.sharedController.firstDateMinorNumber))"
        
        //MARK: - Second most recent
        secondRecentInspectionDateLabel.text = "\(String(OverviewModelController.sharedController.secondInspectionDate))"
        secondRecentMajorViolationLabel.text = "Major: \(String(OverviewModelController.sharedController.secondDateMajorNumber))"
        secondRecentMinorViolationLabel.text = "Minor: \(String(OverviewModelController.sharedController.secondDateMinorNumber))"
        
        
        
        
    }
}
