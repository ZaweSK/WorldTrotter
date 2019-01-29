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
    var mapView: MKMapView!
    var locationManager : CLLocationManager?
    var annotationList: [MKAnnotation]?
    var pinIndex = 0
    
    
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
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let zoomInRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(zoomInRegion, animated: true)
    }
    
    
    
    
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        mapView.delegate = self
        
        let p1 = MKPointAnnotation()
        p1.coordinate = CLLocationCoordinate2D(latitude: 49.195061, longitude: 16.606836)
        let p2 = MKPointAnnotation()
        p2.coordinate = CLLocationCoordinate2D(latitude: 14.058324, longitude: 108.277199)
        
        annotationList = [p1,p2]
        mapView.addAnnotations(annotationList!)
        
        
        //segmentCOntrol
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satelite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViwController loded its view")
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
