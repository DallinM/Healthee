//
//  ThreeInspectionsViewController.swift
//  FirstRoundTest
//
//  Created by Caston  Boyd on 7/17/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
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
        firstRecentInspectionDateLabel.text = "\(String(MapViewController.firstInspectionDate))"
        
        firstRecentMajorViolationLabel.text = " Major: \(String(MapViewController.firstDateMajorNumber))"
        
        firstRecentMinorViolationLabel.text = "Minor: \(String(MapViewController.firstDateMinorNumber))"
        
        //MARK: - Second most recent
        secondRecentInspectionDateLabel.text = "\(String(MapViewController.secondInspectionDate))"
        
        secondRecentMajorViolationLabel.text = "Major: \(String(MapViewController.secondDateMajorNumber))"
        
        secondRecentMinorViolationLabel.text = "Minor: \(String(MapViewController.secondDateMinorNumber))"
        
        //MARK: - Third most recent
        secondRecentInspectionDateLabel.text = "\(String(MapViewController.thirdInspectionDate))"
        
        secondRecentMajorViolationLabel.text = "Major: \(String(MapViewController.thirdDateMajorNumber))"
        
        secondRecentMinorViolationLabel.text = "Minor: \(String(MapViewController.thirdDateMinorNumber))"
    }
}
