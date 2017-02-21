//
//  RealmDataGenerator.swift
//  DenveriOSMeetupRealmDemo
//
//  Created by Nicholas Rose on 2/20/17.
//  Copyright © 2017 Slalom Consulting. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation

/*
enum USBoundary {
    case Northwest
    case Southwest
    case Northeast
    case Southeast
    
    func coordinate2D() -> CLLocationCoordinate2D {
        switch self {
        case .Northwest:
            return CLLocationCoordinate2D(latitude: 47.604116, longitude: -122.331107) // Seattle, WA
        case .Southwest:
            return CLLocationCoordinate2D(latitude: 32.684729, longitude: -117.187427) // Coronado, CA
        case .Northeast:
            return CLLocationCoordinate2D(latitude: 40.771685, longitude: -74.003640) // New York, NY
        case .Southeast:
            return CLLocationCoordinate2D(latitude: 25.718000, longitude: -80.143607) // Miami, FL
        }
    }
} */

class RealmDataGenerator {
    let maximumLatitude: Float = 47.604116
    let maximumLongitude: Float = -80.143607
    let minimumLatitude: Float = 25.718000
    let minimumLongitude: Float = -122.331107
    
    func generateDataWith(closure: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            
            // Get Realm in background thread
            let realm = try! Realm()
            
            for index in 0...100000 {
                // Begin writing data
                let randomLatitude = self.randomFloat(min: self.minimumLatitude, max: self.maximumLatitude)
                let randomLongitude = self.randomFloat(min: self.minimumLongitude, max: self.maximumLongitude)
                
                let model = LocationModel()
                model.latitude = randomLatitude
                model.longitude = randomLongitude
                
                try! realm.write {
                    realm.add(model)
                }
                
                print("Model at index: %i lat: %f long: %f", index, randomLatitude, randomLongitude)
            }
            
            
            DispatchQueue.main.async {
                closure()
            }
        }
    }
    
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
