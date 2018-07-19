//
//  MainPageViewController.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/19/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var pendingIndex : Int?
    private var lastIndex : Int?
    
    
    @IBAction func pageIndicator(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: - Assign Sources to self
        self.delegate = self
        self.dataSource = self
        
        
        
        //MARK: - Set the first view controller of the UIPageViewController from the first index of the array.
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            
        }
    }
    
    
    //MARK: - Instatiate each VC in an array of VC
    
     lazy var pages: [UIViewController] = {
        
        return
             [self.retrieveViewControllerFor(withId: "RestaurantOverivewID"), self.retrieveViewControllerFor(withId: "RestReoccuringViolationsID"), self.retrieveViewControllerFor(withId: "RestPastInspections")]
        
    }()
    
    
    //MARK: - A function to retrieve each View Controllers
    
    func retrieveViewControllerFor(withId identifier: String) -> UIViewController {
        
        return UIStoryboard(name: "SearchSB", bundle: nil) .instantiateViewController(withIdentifier: identifier)
    }
    
    
    //MARK: - Move Page Control Indicator
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.index(of: pendingViewControllers.first!)
        
    }
    
    
    
    
    
    //MARK: - Required Methods For UIPageDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil}
        
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return nil}
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
        
    }
    
}


