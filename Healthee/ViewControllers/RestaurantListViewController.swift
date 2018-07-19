//
//  RestaurantListViewController.swift
//  Healthee
//
//  Created by Caston  Boyd on 7/12/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import UIKit
import os.log
import Pulley

class RestaurantListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBAction func unwindToRestaurantListController(segue:UIStoryboardSegue) {
        
        self.reloadTableView()
    }
    
    
    
    
    static let sharedController = RestaurantListViewController()
    
    @IBOutlet weak var restaurantListTableView: UITableView!
    @IBOutlet weak var topGripperImage: UIImageView!
    @IBOutlet weak var topSeparator: UIView!
    
    
    //MARK: - I also need a method that presents the view controller modally from the
    // bottom when search button is entered.
    
    @IBOutlet weak var topHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topGripperConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        restaurantListTableView.dataSource = self
        restaurantListTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: OverviewModelController.RestaurantNotification.notificationSet, object: nil)
        
        print(OverviewModelController.sharedController.restaurantList.count)
        
    }
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //MARK: - CocoPod for Drawer
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            // We'll configure our UI to respect the safe area. In our small demo app, we just want to adjust the contentInset for the tableview.
            restaurantListTableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // You must wait until viewWillAppear -or- later in the view controller lifecycle in order to get a reference to Pulley via self.parent for customization.
        
        // UIFeedbackGenerator is only available iOS 10+. Since Pulley works back to iOS 9, the .feedbackGenerator property is "Any" and managed internally as a feedback generator.
        if #available(iOS 10.0, *)
        {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            self.pulleyViewController?.feedbackGenerator = feedbackGenerator
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // The bounce here is optional, but it's done automatically after appearance as a demonstration.
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(bounceDrawer), userInfo: nil, repeats: false)
    }
    
    @objc fileprivate func bounceDrawer() {
        
        // We can 'bounce' the drawer to show users that the drawer needs their attention. There are optional parameters you can pass this method to control the bounce height and speed.
        self.pulleyViewController?.bounceDrawer()
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    //MARK: - TableViews ///////////////////////////////////////////////////////////////////
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return OverviewModelController.sharedController.restaurantList.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantListCell", for: indexPath) as? RestaurantListTableViewCell else { return UITableViewCell() }
        
        let restaurantForCell = OverviewModelController.sharedController.restaurantList[indexPath.row]
        
        cell.restaurant = restaurantForCell
        
        return cell
        
    }
    
    @objc func reloadTableView() {
        DispatchQueue.main.async {
            self.restaurantListTableView.reloadData()
        }
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


extension RestaurantListViewController: PulleyDrawerViewControllerDelegate {
    
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 68.0 + bottomSafeArea
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 264.0 + bottomSafeArea
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
    }
    
    // This function is called by Pulley anytime the size, drawer position, etc. changes. It's best to customize your VC UI based on the bottomSafeArea here (if needed). Note: You might also find the `pulleySafeAreaInsets` property on Pulley useful to get Pulley's current safe area insets in a backwards compatible (with iOS < 11) way. If you need this information for use in your layout, you can also access it directly by using `drawerDistanceFromBottom` at any time.
    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat)
    {
        // We want to know about the safe area to customize our UI. Our UI customization logic is in the didSet for this variable.
        drawerBottomSafeArea = bottomSafeArea
        
        /*
         Some explanation for what is happening here:
         1. Our drawer UI needs some customization to look 'correct' on devices like the iPhone X, with a bottom safe area inset.
         2. We only need this when it's in the 'collapsed' position, so we'll add some safe area when it's collapsed and remove it when it's not.
         3. These changes are captured in an animation block (when necessary) by Pulley, so these changes will be animated along-side the drawer automatically.
         */
        if drawer.drawerPosition == .collapsed
        {
            topHeightConstraint.constant = 68.0 + drawerBottomSafeArea
        }
        else
        {
            topHeightConstraint.constant = 68.0
        }
        
        // Handle tableview scrolling / searchbar editing
        
        restaurantListTableView.isScrollEnabled = drawer.drawerPosition == .open || drawer.currentDisplayMode == .leftSide
        
        
        
        if drawer.currentDisplayMode == .leftSide
        {
            topSeparator.isHidden = drawer.drawerPosition == .collapsed
            
        }
        else
        {
            topSeparator.isHidden = false
            
        }
    }
}

//    /// This function is called when the current drawer display mode changes. Make UI customizations here.
//    func drawerDisplayModeDidChange(drawer: PulleyViewController) {
//
//        print("Drawer: \(drawer.currentDisplayMode)")
//        topGripperConstraint.isActive = drawer.currentDisplayMode == .bottomDrawer
//    }
//}




