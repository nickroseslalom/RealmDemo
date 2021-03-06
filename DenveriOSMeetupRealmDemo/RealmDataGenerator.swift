//
//  RealmDataGenerator.swift
//  DenveriOSMeetupRealmDemo
//
//  Created by Nicholas Rose on 2/21/17.
//  Copyright © 2017 Slalom Consulting. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

class RealmDataGenerator {    
    func generateRandomData(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            let maximumLatitude: Float = 47.604116
            let maximumLongitude: Float = -80.143607
            let minimumLatitude: Float = 25.718000
            let minimumLongitude: Float = -122.331107
            
            // Get Realm in background thread
            let realm = try! Realm()
            
            for _ in 0...9000 {
                // Begin writing data
                let randomLatitude = self.randomFloat(min: minimumLatitude, max: maximumLatitude)
                let randomLongitude = self.randomFloat(min: minimumLongitude, max: maximumLongitude)
                
                let model = Location()
                model.latitude = randomLatitude
                model.longitude = randomLongitude
                
                let start = NSDate()
                try! realm.write {
                    realm.add(model)
                }
                let end = NSDate()
                let time = end.timeIntervalSince(start as Date)
                print("Inserted record in", time)
            }
            
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
