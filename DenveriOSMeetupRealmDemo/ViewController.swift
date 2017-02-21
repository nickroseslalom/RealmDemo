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

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var button: UIButton!
    
    let realmDataGenerator: RealmDataGenerator = RealmDataGenerator()
    var results: Results<LocationModel>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        realmDataGenerator.generateDataWith {
            let alertController = UIAlertController(title: "Completed Write Transactions", message: "Inserted 100000 Records.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(action)
            
            self.present(alertController, animated: true, completion: nil)
        } */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
    }
    
    func updateResultsWith(maximumLatitude: CLLocationDegrees, minimumLatitude: CLLocationDegrees, maximumLongitude: CLLocationDegrees, minimumLongitude: CLLocationDegrees) {
        let realm = try! Realm()
        
        self.results = realm.objects(LocationModel.self).filter("latitude <= %f AND latitude >= %f AND longitude <= %f AND longitude >= %f", maximumLatitude, minimumLatitude, maximumLongitude, minimumLongitude)
        
        updateAnnotations()
    }
    
    func updateAnnotations() {
        guard let results = results else {
            return
        }
        
        //mapView.removeAnnotations(mapView.annotations)
        
        let maxCount = results.count > 20 ? 20 : results.count
        
        for index in 0...maxCount - 1 {
            let model = results[index]
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(model.latitude), longitude: CLLocationDegrees(model.longitude))
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    func loadRealm() {
        // Get the default Realm
        let realm = try! Realm()
        for index in 0...1000 {
            let locationModel = LocationModel()
            locationModel.latitude = Float(index)
            locationModel.longitude = Float(index)
            
            try! realm.write {
                realm.add(locationModel)
            }
        }
        
    }

}

extension ViewController: MKMapViewDelegate {
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

