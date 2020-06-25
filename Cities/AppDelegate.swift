//
//  AppDelegate.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var citiesCoordinator: CitiesCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        citiesCoordinator = CitiesCoordinator(navigationController: UINavigationController())
        citiesCoordinator?.show()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = citiesCoordinator?.navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

