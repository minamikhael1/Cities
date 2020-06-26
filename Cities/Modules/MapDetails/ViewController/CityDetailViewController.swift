//
//  CityDetailViewController.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import UIKit
import MapKit

class CityDetailViewController: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var mapView: MKMapView!

    //MARK:- Variables
    private var viewModel: CityViewModel?

    init(viewModel: CityViewModel) {
        super.init(nibName: String(describing: CityDetailViewController.self), bundle: nil)
        self.viewModel = viewModel
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel?.cityName()
        guard let location = viewModel?.location() else { return }
        mapView.centerToLocation(location)
    }
}
