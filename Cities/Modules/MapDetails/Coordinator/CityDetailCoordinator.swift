//
//  CityDetailCoordinator.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation
import UIKit

class CityDetailCoordinator: Coordinator {

    //MARK:- Variables
    var navigationController: UINavigationController
    var detailViewModel: CityViewModel

    //MARK:- Init
    init(navigationController: UINavigationController, cityViewModel: CityViewModel) {
        self.navigationController = navigationController
        self.detailViewModel = cityViewModel
     }

    //MARK:- Helpers
    func getViewController() -> UIViewController {
        return CityDetailViewController(viewModel: detailViewModel)
    }

    func show(present: Bool = false) {
        let viewController = getViewController()
        if present {
            viewController.modalTransitionStyle = .crossDissolve
            self.navigationController.viewControllers.last?.present(viewController, animated: true, completion: nil)
        } else {
            self.navigationController.navigationBar.prefersLargeTitles = true
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
}
