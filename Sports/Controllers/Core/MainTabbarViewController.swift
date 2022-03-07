//
//  MainTabbarViewController.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: HomeViewController())
        vc1.tabBarItem.title = "Home"
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let vc2 = UINavigationController(rootViewController: SportsViewController())
        vc2.tabBarItem.image = UIImage(systemName: "sportscourt")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "sportscourt.fill")
        vc2.tabBarItem.title = "Sports"
        
        setViewControllers([vc1, vc2], animated: true)
    }




}
