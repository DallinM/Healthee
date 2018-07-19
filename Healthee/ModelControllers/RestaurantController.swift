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
    
    var majorNumber = Int()
    var minorNumber = Int()
    
    var firstMostKey = String()
    var secondMostKey = String()
    var thirdMostKey = String()
    var firstMostValue = Int()
    var secondMostValue = Int()
    var thirdMostValue = Int()
    
    
    //MARK: - Top Three Inspections Major and Minor Violations
    var firstDateMajorNumber = Int()
    var secondDateMajorNumber = Int()
    var thirdDateMajorNumber = Int()
    var firstDateMinorNumber = Int()
    var secondDateMinorNumber = Int()
    var thirdDateMinorNumber = Int()
    
    //MARK: - Three Inpsection Dates
    var firstInspectionDate = String()
    var secondInspectionDate = String()
    var thirdInspectionDate = String()
    
    //MARK: - Name of Restaurant
    var nameOfRestaurant = String()
    
    
    //MARK: - Notifications
    
    enum RestaurantNotification {
        static let notificationSet = Notification.Name("NotificationSet")
    }
    
    enum MajorViolationNote {
        static let notificationSetMajor = Notification.Name("NotificationSetMajor")
    }
    
    enum MinorViolationNote {
        static let notificationSetMinor = Notification.Name("NotificationSetMinor")
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
                        let minor = dictionary["minor"] as? Int,
                        let violationTitle = dictionary["violationTitle"] as? String else { continue }
                    
                    //MARK: - creates restaurants from the list above
                    let restaurant = Restaurant(address: address, city: city, inspectionDate: inspectionDate, name: name, major: major, minor: minor, violationTitle: violationTitle)
                    
                    //MARK: - Adds a restaurant to restaurant array instance
                    restaurantArray.append(restaurant)
                    
                }
                
                self.restaurantList = restaurantArray
                
                
                
                
                
                //MARK: - Predicate that is specifies how to order the dictionary
                
                let predicate = { (element: Restaurant) in
                    return element.inspectionDate
                }
                
                let predicateName = { (element: Restaurant) in
                    return element.name
                }
                
                
                //MARK: - Create a dictionary
                
                //grouping - Creates a new dictionary whose keys are the groupings returned by the given closure and whose values are arrays of the elements that returned each key.
                let dictionary = Dictionary(grouping: self.restaurantList, by: predicate)
                let dictionaryName = Dictionary(grouping: self.restaurantList, by: predicateName)
                
                //MARK: - Arrays needed to display info based on certain parameters
                
                // Date array takes every key that has been grouped by the predicate inspection date
                // In the app, the inspections are order by inspection date
                var dateArray = [String]()
                var nameArray = [String]()
                
                // An array for holding the sum of major violations per inspection date
                var totalSumMajorPerDateArray = [Int]()
                // An array for holding the sum of minor violations per inspection date
                var totalSumMinorPerDateArray = [Int]()
                
                // Set array in to most recent date
                var reversedDateArray = [String]()
                var reversedSumMajorPerDateArray = [Int]()
                var reversedSumMinorPerDateArray = [Int]()
                
                for (key, _ ) in dictionaryName {
                    
                    //MARK: - Inspections Dates
                    nameArray.append(key)
                    
                }
                
                //MARK: - For loop to go through each key and value in the dictionary above
                //MARK: - appends each key to an array to be used for past inspection dates
                //MARK: - goes through each restaurant value
                // and finds the int value for Major violaions
                // takes each value, per date key, and puts it into an array assigned to majorViolationsPerDateArray
                //MARK: - Add each value in the array
                // append the values summed up in the previous array and place it
                //MARK: - Did the same thing for minor violations as was done for major
                for (key, value) in dictionary {
                    
                    //MARK: - Inspections Dates
                    dateArray.append(key)
                    reversedDateArray = dateArray.reversed()
                    
                    
                    
                    //MARK: - Major Violations
                    let majorViolationsPerDateArray = value.map({ (restaurant: Restaurant) -> Int in restaurant.major
                    })
                    
                    let majorViolationSummedUp = majorViolationsPerDateArray.reduce(0, {$0 + $1})
                    totalSumMajorPerDateArray.append(majorViolationSummedUp)
                    
                    reversedSumMajorPerDateArray = totalSumMajorPerDateArray.reversed()
                    
                    
                    
                    //MARK: - Minor Violations
                    let minorViolationsPerDateArray = value.map({ (restaurant: Restaurant) -> Int in restaurant.minor
                    })
                    let minorViolationSummedUp = minorViolationsPerDateArray.reduce(0, {$0 + $1})
                    totalSumMinorPerDateArray.append(minorViolationSummedUp)
                    
                    reversedSumMinorPerDateArray = totalSumMinorPerDateArray.reversed()
                    
                }
                
                //MARK: - Take local Major and Minor Violations and assign to global variable
                // First number is most recent inspection number
                
                
                
                self.firstDateMajorNumber = reversedSumMajorPerDateArray[0]
                self.secondDateMajorNumber = reversedSumMajorPerDateArray[1]
                
                
                
                if totalSumMajorPerDateArray.count > 3  {
                    
                    self.thirdDateMajorNumber = reversedSumMajorPerDateArray[2]
                    
                } else {
                    
                    self.thirdDateMajorNumber = 0
                    
                }
                
                
                self.firstDateMinorNumber = reversedSumMinorPerDateArray[0]
                self.secondDateMinorNumber = reversedSumMinorPerDateArray[1]
                
                
                if totalSumMinorPerDateArray.count > 3  {
                    
                    self.thirdDateMinorNumber = reversedSumMinorPerDateArray[2]
                    
                } else {
                    
                    self.thirdDateMinorNumber = 0
                    
                }
                
                
                
                
                
                self.firstInspectionDate = reversedDateArray[0]
                self.secondInspectionDate = reversedDateArray[1]
                
                
                if dateArray.count > 3  {
                    
                    self.thirdInspectionDate = reversedDateArray[2]
                    
                } else {
                    
                    self.thirdInspectionDate = ""
                    
                }
                
                
                
                //MARK: - Number of Occurrences, Violation Name
                let violationArray = self.restaurantList.map({ (restaurant: Restaurant) -> String in restaurant.violationTitle
                })
                
                
                var counts = [String: Int]()
                
                
                // Count the values with using forEach
                violationArray.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }
                let sortedArrayForViolations = (counts.sorted(by: {$0.1 > $1.1}))
                
                
                //MARK: - Assign to global variable
                let firstMostKey = sortedArrayForViolations[0].key
                let secondMostKey = sortedArrayForViolations[1].key
                let thirdMostKey = sortedArrayForViolations[2].key
                let firstMostValue = sortedArrayForViolations[0].value
                let secondMostValue = sortedArrayForViolations[1].value
                let thirdMostValue = sortedArrayForViolations[2].value
                
                self.firstMostKey = firstMostKey
                self.secondMostKey = secondMostKey
                self.thirdMostKey = thirdMostKey
                self.firstMostValue = firstMostValue
                self.secondMostValue = secondMostValue
                self.thirdMostValue = thirdMostValue
                
                
                //MARK: - Number of major violations
                let majorArray = self.restaurantList.map({ (restaurant: Restaurant) -> Int in restaurant.major
                })
                //MARK: - Number of minor violations
                let minorArray = self.restaurantList.map({ (restaurant: Restaurant) -> Int in restaurant.minor
                })
                //MARK: - Add the Violations
                let majorSum = majorArray.reduce(0, {$0 + $1})
                let minorSum = minorArray.reduce(0, {$0 + $1})
                
                //MARK: - Assign Values outside async
                self.majorNumber = majorSum
                self.minorNumber = minorSum
                
            })
            
            
        }
        
    }
    
}
