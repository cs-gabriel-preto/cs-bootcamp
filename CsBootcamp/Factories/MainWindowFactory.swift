//
//  MainWindowFactory.swift
//  CsBootcamp
//
//  Created by Andre Rodrigues on 06/04/18.
//  Copyright © 2018 Bootcampers. All rights reserved.
//

import UIKit

final class MainWindowFactory {
    
    static func make() -> UIWindow {
        
        let moviesListViewController = MoviesListSceneFactory.make()
        let favoritesListViewController = FavoritesListSceneFactory.make()
        
        let moviesNavigationController = UINavigationControllerFactory.make(with: moviesListViewController)
        let favoritesNavigationController = UINavigationControllerFactory.make(with: favoritesListViewController)
        
        let tabBarController = UITabBarControllerFactory.make(with: moviesNavigationController, favoritesNavigationController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
//        window.rootViewController = MoviesFilterSceneFactory.make()
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        
        return window
    }
}
