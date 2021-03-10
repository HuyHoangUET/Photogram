//
//  HomeTabbarController.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit

class HomeTabbarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewControllers()
    }
    
    func initViewControllers(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        // Home
        let homeView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let homeNavigationController = UINavigationController(rootViewController: homeView)
        homeView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        
        // Search
        let searchView = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let searchNavigationController = UINavigationController(rootViewController: searchView)
        searchView.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        // Library
        let libraryView = storyboard.instantiateViewController(withIdentifier: "LibraryViewController") as! LibraryViewController
        let libraryNavigationController = UINavigationController(rootViewController: libraryView)
        libraryView.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "folder.fill"), tag: 3)
        
        self.viewControllers = [homeNavigationController, searchNavigationController, libraryNavigationController]
        
        let homeTabbarNavi = UINavigationController(rootViewController: self)
        let homeNavigator = DefaultHomeNavigator(navigationController: homeTabbarNavi)
        homeView.viewModel = HomeViewmodel(navigator: homeNavigator)
    }
}
