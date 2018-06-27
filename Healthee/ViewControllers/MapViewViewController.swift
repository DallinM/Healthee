//
//  MapViewViewController.swift
//  Healthee
//
//  Created by Landon McKell on 6/27/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import UIKit
import MapKit

class MapViewViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapTableView: UITableView!
    
    let locationManager = CLLocationManager()
    
//----------------------------------- Do Not Touch --------------------------------------------//
    
    // Convience Function and Initial Mapview Placement
    // (m^2) converted (m) distance of Salt Lake County = 45717.8513m
    private let regionRadius: CLLocationDistance = 45700
    private let initialLocation = CLLocation(latitude: 40.756370, longitude: -111.887978)
    
    // a convience function
    func centreMap(on location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
//-------------------------------------------------------------------------------------------//

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Puts a thin border around table view
        mapTableView.layer.masksToBounds = true
        mapTableView.layer.borderColor = UIColor.darkGray.cgColor
        mapTableView.layer.borderWidth = 0.5
        
        // centers the mapView on salt lake county
        centreMap(on: initialLocation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAccess()
    }
    
    // Asking for user permission to access current location
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("Location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
