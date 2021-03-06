//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Peter on 24/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    // MARK: - Stored Properities
    
    var mapView: MKMapView!
    var locationManager : CLLocationManager?
    var annotationList: [MKAnnotation]?
    var pinIndex = 0
    
    
    // MARK: - @IBActions & @IBOutlets
    
    @IBAction func getRandomLocation(_ sender: UIBarButtonItem) {
        let region = MKCoordinateRegion(center: annotationList![pinIndex].coordinate,
                                        latitudinalMeters: 700,
                                        longitudinalMeters: 70)
        mapView.setRegion(region, animated: true)
        pinIndex += 1
        if pinIndex == 2 { pinIndex = 0}
    }
    
    @IBAction func showMyLocation(_ sender: UIBarButtonItem) {

        locationManager?.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    // MARK: - MKMapViewDelegate methods
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let zoomInRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(zoomInRegion, animated: true)
    }
    
    // MARK: - VC life cycle
    
    override func loadView() {
        
        locationManager = CLLocationManager()
        
        mapView = MKMapView()
        view = mapView
        mapView.delegate = self
        
        let p1 = MKPointAnnotation()
        p1.coordinate = CLLocationCoordinate2D(latitude: 49.195061, longitude: 16.606836)
        let p2 = MKPointAnnotation()
        p2.coordinate = CLLocationCoordinate2D(latitude: 14.058324, longitude: 108.277199)
        
        annotationList = [p1,p2]
        mapView.addAnnotations(annotationList!)
        
        
        // segment control in code
        
        let standardString = NSLocalizedString("Standard", comment: "Standard Map View")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite Map View")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid Map View")
        
        let segmentedControl = UISegmentedControl(items: [standardString,satelliteString,hybridString])
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        
        
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
    }
    
    
    // MARK: - Action for SegmentedControl
    
    @objc private func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default: break
        }
    }
}
