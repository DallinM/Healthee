//
//  SearchBarDesignable.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/12/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import Foundation

import UIKit
import Material

@IBDesignable class DesignableSearchBar: UISearchBar {
    
    lazy var searchBarColor = hexStringToUIColor(hex: "#E9E9E9")
    
    
    
    @IBInspectable var searchBarColorBG: UIColor = UIColor.white {
        didSet{
            backgroundColor = searchBarColorBG
        }
        
    }
    
    @IBInspectable var searchBarStyleColor : UIColor = UIColor.white{
        
        didSet{
            
            self.barTintColor = searchBarStyleColor
        }
    }
    
    
    
    @IBInspectable var borderShadow: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderShadow.cgColor
            
        }
    }
    
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    override var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    override var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    @IBInspectable var barStyleTint: UIColor = UIColor.clear {
        didSet{
            self.barTintColor = barStyleTint
            
        }
    }
    
    
}
