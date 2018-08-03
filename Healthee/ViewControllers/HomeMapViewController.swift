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
import November

class MapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var homeSearchBar: DesignableSearchBar!
    
    let locationManager = CLLocationManager()
    
    // Convience Function and Initial Mapview Placement
    // (m^2) converted (m) distance of Salt Lake County = 45717.8513m
    private let regionRadius: CLLocationDistance = 45700
    private let initialLocation = CLLocation(latitude: 40.756370, longitude: -111.887978)
    
    // a convience function
    func centreMap(on location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    
    
    
    //MARK: - Singleton
    static let sharedMapViewController = MapViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //FirebaseApp.configure()

        homeSearchBar.delegate = self
        requestLocationAccess()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        // centers the mapView on salt lake county
        centreMap(on: initialLocation)
        searchForRestaurants()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllData { (restaurant) in
            print(restaurant.count)
        }
        
        
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
    
    // Nearby Restuarants Appear UserLocation
    func searchForRestaurants(){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Restuarants"
        request.naturalLanguageQuery = "Coffee Shops"
        request.naturalLanguageQuery = "Bars"
        request.naturalLanguageQuery = "Fast Food"
        
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                return
            }
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
        
    }
    
    //Adjusting the user location zoom
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        var region = MKCoordinateRegion()
        region.span = MKCoordinateSpanMake(0.7, 0.7); //Zoom distance
        let coordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude:  userLocation.coordinate.longitude)
        region.center = coordinate
        mapView.setRegion(region, animated: true)
    }
    
    
    
    
    
    var restaurantList = [Restaurant]()
    
    var restaurantListModified = [String : [Restaurant]]()
    
    
    //MARK: - Arrays for Tableviews with Notification Centers
    static var tableViewNameArray = [String]() {
        
        didSet {
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: MapViewController.RestaurantNotification.notificationSet, object: self)
                
            }
        }
    }
    
    
    static var tableViewAddressArray = [String]() {
        
        didSet {
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: MapViewController.RestaurantAddressNotification.notificationSetforAddress, object: self)
            }
        }
    }
    
    
    //MARK: - Three Inpsection Dates
    static var firstInspectionDate = String()
    static var secondInspectionDate = String()
    static var thirdInspectionDate = String()
    
    
    //MARK: - Major and Minor Numbers
    static var firstDateMajorNumber = Int()
    static var secondDateMajorNumber = Int()
    static var thirdDateMajorNumber = Int()
    static var firstDateMinorNumber = Int()
    static var secondDateMinorNumber = Int()
    static var thirdDateMinorNumber = Int()
    
    //MARK: - Title and Value Amount of Reoccurring Violations
    
    static var firstMostKey = String()
    static var secondMostKey = String()
    static var thirdMostKey = String()
    static var firstMostValue = Int()
    static var secondMostValue = Int()
    static var thirdMostValue = Int()
    
    
    
    
    //MARK: - Notificaton Names
    
    enum RestaurantNotification {
        static let notificationSet = Notification.Name("NotificationSet")
    }
    enum RestaurantAddressNotification {
        static let notificationSetforAddress = Notification.Name("NotificationSetForAddress")
    }
    
    
    
    
    var ref: DatabaseReference?
    
    let restaurantGroup = DispatchGroup()
    
    
    func fetchAllData( completion: @escaping (_ call: [Restaurant]) -> Void) {
        
        self.ref = Database.database().reference()
        
        self.ref?.observe(.value, with: { (snap) in
            guard let topArray = snap.value as? [[String:Any]] else {print(":(") ; return }
            var restaurantArray = [Restaurant]()
            
            for dictionary in topArray {
                self.restaurantGroup.enter()
                guard let address = dictionary["Address"] as? String,
                    let city = dictionary["City"] as? String,
                    let inspectionDate = dictionary["Inspection Date"] as? String,
                    let name = dictionary["Name"] as? String,
                    let major = dictionary["Number of Occurrences (Critical Violations)"] as? Int,
                    let minor = dictionary["Number of Occurrences (Noncritical Violations)"] as? Int,
                    let violationTitle = dictionary["Violation Title"] as? String else { continue }
                
                //MARK: - creates restaurants from the list above
                let restaurant = Restaurant(address: address, city: city, inspectionDate: inspectionDate, name: name, major: major, minor: minor, violationTitle: violationTitle)
                
                
                //MARK: - Adds a restaurant to restaurant array instance
                restaurantArray.append(restaurant)
                
            }
            
            self.restaurantList = restaurantArray
            self.restaurantGroup.leave()
            
            
            completion(self.restaurantList)
            
            
            let dictionaryNew = Dictionary(grouping: self.restaurantList) { $0.name + " " + $0.address}
            
            self.restaurantListModified = dictionaryNew
        })
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        var filteredArray = [[Restaurant]]()
        
        guard let userSearch = searchBar.text?.uppercased() else { return }
        pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)
        
        var nameArray = [String]()
        var addressArray = [String]()
        var violationTitleArray = [String]()
        for ( _, value) in restaurantListModified {
            
            if value[0].name.hasPrefix(userSearch.uppercased()){
                filteredArray.append(value)
                
            }
        }
        
        
        
        let predicate = { (element: Restaurant) in
            return element.inspectionDate
        }
        
        
        var totalSumMajorPerDateArray = [Int]()
        var totalSumMinorPerDateArray = [Int]()
        var dateArray = [String]()
        
        
        for subarray in filteredArray {
            
            let nameArrayForTBView = subarray[0].name
            nameArray.append(nameArrayForTBView)
            let addressArrayForTB = subarray[0].address
            addressArray.append(addressArrayForTB)
            
            for item in subarray {
                violationTitleArray.append(item.violationTitle)
            }
            
            
            
            let assortmentDate = subarray.sorted(by: {$0.inspectionDate > $1.inspectionDate })
            
            let dictionaryAddress = Dictionary(grouping: assortmentDate, by: predicate)
            
            for ( key, value) in dictionaryAddress {
                
                dateArray.append(key)
                
                
                
                let majorViolationsPerDateArray = value.map({ (restaurant: Restaurant) -> Int in restaurant.major
                })
                
                let majorViolationSummedUp = majorViolationsPerDateArray.reduce(0, {$0 + $1})
                totalSumMajorPerDateArray.append(majorViolationSummedUp)
                
                let minorViolationsPerDateArray = value.map({ (restaurant: Restaurant) -> Int in restaurant.minor                })
                
                let minorViolationSummedUp = minorViolationsPerDateArray.reduce(0, {$0 + $1})
                totalSumMinorPerDateArray.append(minorViolationSummedUp)
                
                //MARK: - Number of Occurrences, Violation Name
                
                var counts = [String: Int]()
                
                
                // Count the values using forEach
                violationTitleArray.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }
                let sortedArrayForViolations = (counts.sorted(by: {$0.1 > $1.1}))
                
                
                //MARK: - Assign Violation title and Occurrence account to global variable
                let firstMostKey = sortedArrayForViolations[0].key
                let secondMostKey = sortedArrayForViolations[1].key
                let thirdMostKey = sortedArrayForViolations[2].key
                let firstMostValue = sortedArrayForViolations[0].value
                let secondMostValue = sortedArrayForViolations[1].value
                let thirdMostValue = sortedArrayForViolations[2].value
                
                //MARK: - Assign Violation title and Occurrence account to global variable
                MapViewController.firstMostKey = firstMostKey
                MapViewController.secondMostKey = secondMostKey
                MapViewController.thirdMostKey = thirdMostKey
                MapViewController.firstMostValue = firstMostValue
                MapViewController.secondMostValue = secondMostValue
                MapViewController.thirdMostValue = thirdMostValue
                
                
                
            }
            
            //MARK: - Major Sums
            MapViewController.firstDateMajorNumber = totalSumMajorPerDateArray[0]
            
            if  totalSumMajorPerDateArray.count >= 2  {
                MapViewController.secondDateMajorNumber = totalSumMajorPerDateArray[1]
                
            } else { MapViewController.secondDateMajorNumber = 0 }
            
            if totalSumMajorPerDateArray.count >= 3  { MapViewController.thirdDateMajorNumber = totalSumMajorPerDateArray[2] } else { MapViewController.thirdDateMajorNumber = 0 }
            
            //MARK: - Minor Sums
            MapViewController.firstDateMinorNumber = totalSumMinorPerDateArray[0]
            if totalSumMinorPerDateArray.count >= 2  { MapViewController.secondDateMinorNumber = totalSumMinorPerDateArray[1] } else { MapViewController.secondDateMinorNumber = 0 }
            
            if totalSumMinorPerDateArray.count >= 3  { MapViewController.thirdDateMinorNumber = totalSumMinorPerDateArray[2] } else { MapViewController.thirdDateMinorNumber = 0 }
            
            
            //MARK: - Date for Major and Minors
            MapViewController.firstInspectionDate = dateArray[0]
            
            if dateArray.count >= 2  { MapViewController.thirdInspectionDate = dateArray[1] } else { MapViewController.thirdInspectionDate = "" }
            
            if dateArray.count >= 3  { MapViewController.thirdInspectionDate = dateArray[2] } else { MapViewController.thirdInspectionDate = "" }
            
        }
        
        
        
        
        print(dateArray[1])
        
        
        
        MapViewController.tableViewNameArray = nameArray
        MapViewController.tableViewAddressArray = addressArray
    }
}




extension MapViewController: PulleyPrimaryContentControllerDelegate {
    
    func makeUIAdjustmentsForFullscreen(progress: CGFloat, bottomSafeArea: CGFloat)
    {
        guard let drawer = self.pulleyViewController, drawer.currentDisplayMode == .bottomDrawer else { return }
        
    }
}
