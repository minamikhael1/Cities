//
//  MKMapViewExtension.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 7000) {
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: CLLocationDistance(exactly: regionRadius)!,
                                        longitudinalMeters: CLLocationDistance(exactly: regionRadius)!)
        setRegion(regionThatFits(region), animated: true)
    }
}
