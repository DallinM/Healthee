//
//  MainViewController.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/19/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import UIKit
import Canvas

class MainViewController: UIViewController {
    
    static let shared = MainViewController()
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var heartView: CSAnimationView!
    @IBOutlet weak var heartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var buttonPressed = false
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        self.heartView.startCanvasAnimation()
        
        if buttonPressed == true {
            self.heartButton.setImage(UIImage(named: "Shape"), for: .normal)
            buttonPressed = false
        }
            
        else {
            if buttonPressed == false {
                self.heartButton.setImage(UIImage(named: "heartIsRed"), for: .normal)
                buttonPressed = true
            }
            
        }
    }
}
