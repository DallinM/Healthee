//
//  RestaurantListTableViewCell.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/12/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//


import UIKit

class RestaurantListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    
    var nameOfRestaurant: String? {
        didSet {
            updateViews()
            
        }
    }
    var addressOfRestaurant: String? {
        didSet {
            updateViews()
            
        }
    }
    
    func updateViews() {
        guard let nameRestaurant = nameOfRestaurant  else { return }
        guard let addressRestaurant = addressOfRestaurant  else { return }
        
        restaurantName.text = "Name: \(nameRestaurant)"
        restaurantAddress.text = "Address: \(addressRestaurant)"
        
    }
}

