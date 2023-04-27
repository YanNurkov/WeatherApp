//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewModel = MainViewModel()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: MainViewController(viewModel: viewModel))
        window?.makeKeyAndVisible()
    }
}
