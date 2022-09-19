//
//  TabBarController.swift
//  MovieManager
//
//  Created by Leandro Diaz on 9/18/22.
//

import UIKit

class TabBarController: UITabBarController {
    var viewModel: ContentViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }
    
    private func createTabBar() {
        UITabBar.appearance().tintColor = .systemRed
        self.viewControllers = [createHomeVC(), createFavoritesVC()]
    }
    
    private func createHomeVC() -> UINavigationController {
        let home = HomeViewController()
        
        home.title    = "Home Controller"
        home.tabBarItem   = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        tabBarItem.tag = 0
    
        return UINavigationController(rootViewController: home)
    }

    private func createFavoritesVC() -> UINavigationController  {
        let favoritesVC  = FavoritesViewController()
        favoritesVC.title  = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        tabBarItem.tag = 1
        
        return UINavigationController(rootViewController: favoritesVC)
    }
}
