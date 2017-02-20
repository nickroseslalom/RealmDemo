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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRealm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
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

extension ViewController : MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("User Location: %@", userLocation)
    }
}

