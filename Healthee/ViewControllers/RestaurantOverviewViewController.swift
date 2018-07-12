//
//  RestaurantOverviewViewController.swift
//  Healthee
//
//  Created by Dallin McConnell on 6/29/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import UIKit
import Firebase
import Pulley

class OverviewViewController: PulleyViewController, UISearchBarDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseApp.configure()
    }
    
}
