//
//  RealmDataGenerator.swift
//  DenveriOSMeetupRealmDemo
//
//  Created by Nicholas Rose on 2/21/17.
//  Copyright © 2017 Slalom Consulting. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataGenerator {
    func generateData(closure: @escaping () -> ()) {
        guard let jsonArray = readJSONFile() else {
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            // Get Realm in background thread
            let realm = try! Realm()
            
            for dict in jsonArray {
                let location = Location()
                location.latitude = dict["latitude"] as! Float
                location.longitude = dict["longitude"] as! Float
                
                try! realm.write {
                    realm.add(location)
                }
            }
            
            DispatchQueue.main.async {
                closure()
            }
        }
    }
    
    func readJSONFile() -> [NSDictionary]? {
        guard let path = Bundle.main.path(forResource: "locations", ofType: "json") else {
            return nil
        }
        
        guard let jsonData = NSData(contentsOfFile: path) else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? [NSDictionary]
        }
        catch {
            return nil
        }
    }
}
