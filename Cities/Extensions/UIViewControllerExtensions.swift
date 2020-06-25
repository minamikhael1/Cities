//
//  UIViewControllerExtensions.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentSingleButtonDialog(alert: SingleButtonAlert) {
        DispatchQueue.main.async {[weak self] in
            let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: alert.action.buttonTitle, style: .default, handler: { _ in alert.action.handler?() }))
            self?.present(alertController, animated: true, completion: nil)
        }
    }

    func presentNetworkError(error: DataError?) {
        guard let error = error else {
            self.presentSingleButtonDialog(alert: SingleButtonAlert(title: "Unknown Error",
                                                                    message: "please try again later.",
                                                                    action: AlertAction(buttonTitle: "OK", handler: {})))
            return
        }
        var alert: SingleButtonAlert?
        switch error {
        case .unknown:
            alert = SingleButtonAlert(title: "Unknown Error", message: "please try again later.", action: AlertAction(buttonTitle: "OK", handler: {}))
        case .noJSONData:
            alert = SingleButtonAlert(title: "Data Error", message: "Data is empty", action: AlertAction(buttonTitle: "OK", handler: {}))
        case .JSONDecoder:
            alert = SingleButtonAlert(title: "Data Error", message: "Data is not in the correct format", action: AlertAction(buttonTitle: "OK", handler: {}))
        case .dataLocation:
            alert = SingleButtonAlert(title: "Data Error", message: "Data location is not accurate", action: AlertAction(buttonTitle: "OK", handler: {}))
        }
        guard let finalAlert = alert else { return }
        self.presentSingleButtonDialog(alert: finalAlert)
    }
}
