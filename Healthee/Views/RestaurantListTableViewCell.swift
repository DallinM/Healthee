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
    
    var restaurant: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let restaurant = restaurant else { return }
        
        restaurantName.text = "Name: \(String(restaurant.name))"
        restaurantAddress.text = "Address: \(String(restaurant.address))"
        
    }
    
}
