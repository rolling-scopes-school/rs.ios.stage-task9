//
//  SceneDelegate.swift
//  RSSchool_T9
//
//  Created by Uladzislau Volchyk on 23.07.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else {
            fatalError("LOL, be careful, drink a water")
        }
        
        let tabBarController = RSTabBarViewController()
        
        let settingsController = RSSettingsViewController()
        let collectionController = RSCollectionViewController()
        
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)
        collectionController.tabBarItem = UITabBarItem(title: "Items", image: UIImage(systemName: "square.grid.2x2"), tag: 1)
        
        tabBarController.viewControllers = [
            collectionController,
            RSNavigationViewController(rootViewController: settingsController)
        ]
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()   
    }
}

