//
//  ActionViewController.swift
//  DenveriOSMeetupRealmDemo
//
//  Created by Nicholas Rose on 2/21/17.
//  Copyright © 2017 Slalom Consulting. All rights reserved.
//

import UIKit
import RealmSwift

class ActionViewController: UIViewController {

    let realmDataGenerator: RealmDataGenerator = RealmDataGenerator()
    
    @IBAction func beginWrites(_ sender: Any) {
        realmDataGenerator.generateRandomData {
            let alertController = UIAlertController(title: "Completed Write Transactions", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(action)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func deleteAll(_ sender: Any) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
}
