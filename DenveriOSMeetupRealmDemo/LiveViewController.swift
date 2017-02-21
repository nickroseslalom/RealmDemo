//
//  ViewController.swift
//  DenveriOSMeetupRealmDemo
//
//  Created by Nicholas Rose on 2/20/17.
//  Copyright © 2017 Slalom Consulting. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class LiveViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var button: UIButton!
    
    var realmDataGenerator: RealmDataGenerator = RealmDataGenerator()
    var results: Results<Location>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        realmDataGenerator.generateDataIn(region: mapView.region) { 
            
        }
    }
    
    func updateResultsWith(maximumLatitude: CLLocationDegrees, minimumLatitude: CLLocationDegrees, maximumLongitude: CLLocationDegrees, minimumLongitude: CLLocationDegrees) {
        let realm = try! Realm()
        
        self.results = realm.objects(Location.self).filter("latitude <= %f AND latitude >= %f AND longitude <= %f AND longitude >= %f", maximumLatitude, minimumLatitude, maximumLongitude, minimumLongitude)
        
        updateAnnotations()
    }
    
    func updateAnnotations() {
        guard let results = results else {
            return
        }
        
        mapView.removeAnnotations(mapView.annotations)
        
        var annotations: [MKPointAnnotation] = Array()
        results.forEach { (model) in
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(model.latitude), longitude: CLLocationDegrees(model.longitude))
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
}

extension LiveViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("User Location: %@", userLocation)
        
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000);
        self.mapView.setRegion(region, animated: true)
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let region = mapView.region
        
        let maximumLatitude = region.center.latitude + region.span.latitudeDelta
        let minimumLatitude = region.center.latitude - region.span.latitudeDelta
        let maximumLongitude = region.center.longitude + region.span.longitudeDelta
        let minimumLongitude = region.center.longitude - region.span.longitudeDelta
        
        updateResultsWith(maximumLatitude: maximumLatitude, minimumLatitude: minimumLatitude, maximumLongitude: maximumLongitude, minimumLongitude: minimumLongitude)
    }
}

