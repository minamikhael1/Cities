//
//  CitiesCoordinator.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import UIKit
import Foundation

protocol CitiesCoordinatorDelegate {
    func citySelected(city: CityViewModel)
}

class CitiesCoordinator: Coordinator {

    //MARK:- Variables
    var navigationController: UINavigationController
    var citiesViewModel = CitiesViewModel()
    var delegate: CitiesCoordinatorDelegate?

    //MARK:- Init
     init(navigationController: UINavigationController) {
         self.navigationController = navigationController
     }

    //MARK:- Helpers
    func getViewController() -> UIViewController {
        let viewController = CitiesViewController(viewModel: citiesViewModel)
        viewController.coordinatorDelegate = self
        return viewController
    }

    func show(present: Bool = false) {
        let nowPlayingViewController = getViewController()
        if present {
            nowPlayingViewController.modalTransitionStyle = .crossDissolve
            self.navigationController.viewControllers.last?.present(nowPlayingViewController, animated: true, completion: nil)
        } else {
            self.navigationController.navigationBar.prefersLargeTitles = true
            self.navigationController.pushViewController(nowPlayingViewController, animated: true)
        }
    }
}

extension CitiesCoordinator: CitiesCoordinatorDelegate {
    func citySelected(city: CityViewModel) {
        CityDetailCoordinator(navigationController: self.navigationController, cityViewModel: city).show()
    }
}
