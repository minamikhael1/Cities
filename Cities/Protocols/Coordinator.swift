//
//  Coordinator.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func getViewController() -> UIViewController
    func show(present: Bool)
}
