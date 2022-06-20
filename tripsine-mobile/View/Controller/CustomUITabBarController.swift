//
//  CustomUITabBarController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 18/06/22.
//

import UIKit

class CustomUITabBarController: UITabBarController {

    @IBOutlet weak var itemsTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTabBar.unselectedItemTintColor = .white

        if let fontDefinition = UIFont(name: "Poppins-SemiBold", size: 15) {
            // mark: Home setup
            if let homeTabBar = itemsTabBar?.items?[0] {
                homeTabBar.setTitleTextAttributes([NSAttributedString.Key.font: fontDefinition], for: .selected)
                homeTabBar.setTitleTextAttributes([NSAttributedString.Key.font: fontDefinition], for: .normal)
            }
            
            
            // mark: Profile setup
            if let profileTabBar = itemsTabBar?.items?[1] {
                profileTabBar.setTitleTextAttributes([NSAttributedString.Key.font: fontDefinition], for: .selected)
                profileTabBar.setTitleTextAttributes([NSAttributedString.Key.font: fontDefinition], for: .normal)
            }
            
            
            // mark: Favorites setup
            if let favoritesTabBar = itemsTabBar?.items?[2] {
                favoritesTabBar.setTitleTextAttributes([NSAttributedString.Key.font: fontDefinition], for: .selected)
                favoritesTabBar.setTitleTextAttributes([NSAttributedString.Key.font: fontDefinition], for: .normal)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
