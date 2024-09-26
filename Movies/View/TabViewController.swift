//
//  TabViewController.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 12/09/24.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearence()
        viewControllers = [
            createTabBarItem(rootViewController: MovieListViewController(), title: "generic.discover".localized() , image: UIImage(systemName: "house")),
            createTabBarItem(rootViewController: SearchMovieViewController(), title: "generic.search".localized(), image: UIImage(systemName: "magnifyingglass"))
        ]
    }
    
    private func setupTabBarAppearence() {
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
    }
    private func createTabBarItem(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
