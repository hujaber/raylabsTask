//
//  MapKitView.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/19/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import MapKit

final class MapKitView: MKMapView {
    
    private var latitude: Double!
    private var longitude: Double!
    
    private var initialLocation: CLLocation {
        .init(latitude: latitude, longitude: longitude)
    }
    
    private var regionRadius: CLLocationDistance = 1000
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func centerToCoordinates(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        centerToInitialLocation()
       // addPin()
    }
    
    private func initialSetup() {
        mapType = .standard
    }
    
    private func centerToInitialLocation() {
        let coordinateRegion = MKCoordinateRegion(
            center: initialLocation.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    private func addPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = initialLocation.coordinate
        pin.title = ""
        pin.subtitle = nil
        addAnnotation(pin)
    }
    
    
    
}

extension MapKitView: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        addPin()
    }
}
