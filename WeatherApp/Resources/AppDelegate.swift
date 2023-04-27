//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewModel = MainViewModel()
        self.window = UIWindow.init()
        self.window?.bounds = UIScreen.main.bounds
        self.window?.rootViewController = UINavigationController(rootViewController: MainViewController(viewModel: viewModel))
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}


