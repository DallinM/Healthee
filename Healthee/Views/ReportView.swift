//
//  ReportView.swift
//  Healthee
//
//  Created by Dallin McConnell on 7/9/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import UIKit

class ReportView: UIView {

    @IBInspectable var shadowRadius: CGFloat = 1 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 50 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        } set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable override var shadowColor: UIColor? {
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
}
