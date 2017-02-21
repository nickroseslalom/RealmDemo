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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func beginWrites(_ sender: Any) {
        realmDataGenerator.generateRandomData {
            let alertController = UIAlertController(title: "Completed Write Transactions", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(action)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func beginReads(_ sender: Any) {
        let realm = try! Realm()
        
        // Lazy loaded. 
        let results = realm.objects(Location.self)
    }
    @IBAction func deleteAll(_ sender: Any) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
