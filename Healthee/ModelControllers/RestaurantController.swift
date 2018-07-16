//
//  RestaurantController.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/12/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import Foundation
import Firebase


class OverviewModelController {
    
    //MARK: - SharedController
    static let sharedController = OverviewModelController()
    
    //MARK: - Source of Truth
    var restaurantList = [Restaurant]() {
        
        didSet{
            NotificationCenter.default.post(name: OverviewModelController.RestaurantNotification.notificationSet, object: self)
        }
        
    }
    
    enum RestaurantNotification {
        static let notificationSet = Notification.Name("NotificationSet")
    }
    
    
    
    
    
    //MARK: - Firebase DataReference
    var ref: DatabaseReference?
    
    
    //MARK: - CRUD
    
    func firebaseDataFetch(userSearch: String) {
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
            self.ref = Database.database().reference()
            
            self.ref?.child(userSearch.uppercased()).observe( .value, with: { (snap) in
                guard let topArray = snap.value as? [[String:Any]] else {print(":(") ; return }
                var restaurantArray = [Restaurant]()
                
                for dictionary in topArray {
                    
                    guard let address = dictionary["address"] as? String,
                        let city = dictionary["city"] as? String,
                        let inspectionDate = dictionary["inspectionDate"] as? String,
                        let name = dictionary["name"] as? String,
                        let major = dictionary["major"] as? Int,
                        let minor = dictionary["minor"] as? Int else { continue }
                    
                    
                    //MARK: - creates restaurants from the list above
                    let restaurant = Restaurant(address: address, city: city, inspectionDate: inspectionDate, name: name, major: major, minor: minor)
                    
                    //MARK: - Adds a restaurant to restaurant array instance
                    restaurantArray.append(restaurant)
                    
                }
                
                self.restaurantList = restaurantArray
                
                
            })
        }
        
    }
    
}
