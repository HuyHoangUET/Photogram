//
//  HomeTabbarController.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit

class HomeTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewControllers()
    }
    
    func initViewControllers() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        // Home
        let homeView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        let homeNavigationController = UINavigationController(rootViewController: homeView ?? HomeViewController())
        homeView?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        
        // Search
        guard let searchView = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {return}
        let searchNavigationController = UINavigationController(rootViewController: searchView)
        searchView.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        // Library
        let libraryView = storyboard.instantiateViewController(withIdentifier: "LibraryViewController") as? LibraryViewController
        let libraryNavigationController = UINavigationController(rootViewController: libraryView ?? LibraryViewController())
        libraryView?.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "folder.fill"), tag: 3)
        
        // Profile
        let profileView = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        let profileNavigationController = UINavigationController(rootViewController: profileView ?? ProfileViewController())
        profileView?.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle.fill"), tag: 4)
        let profileNavigator = DefaultProfileNavigator(navigationController: profileNavigationController)
        profileView?.viewModel = ProfileViewmodel(navigator: profileNavigator)
        
        self.viewControllers = [homeNavigationController, searchNavigationController, libraryNavigationController, profileNavigationController]
        
        let homeNavigator = DefaultHomeNavigator(navigationController: homeNavigationController)
        homeView?.viewModel = HomeViewmodel(navigator: homeNavigator)
    }
}
