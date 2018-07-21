//
//  HomeMapViewController.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/12/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//


import UIKit
import Pulley
import MapKit
import Firebase

class MapViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var homeSearchBar: DesignableSearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        homeSearchBar.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let usersSearch = searchBar.text else { return }
        OverviewModelController.sharedController.firebaseDataFetch(userSearch: usersSearch)
        
        pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)
        self.homeSearchBar.resignFirstResponder()
        
        DispatchQueue.main.async {
            
            self.homeSearchBar.text = ""
            
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.homeSearchBar.becomeFirstResponder()
    }
    
    
}



extension MapViewController: PulleyPrimaryContentControllerDelegate {
    
    func makeUIAdjustmentsForFullscreen(progress: CGFloat, bottomSafeArea: CGFloat)
    {
        guard let drawer = self.pulleyViewController, drawer.currentDisplayMode == .bottomDrawer else { return }
        
    }
}

