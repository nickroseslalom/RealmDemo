//
//  LocationModel.swift
//  DenveriOSMeetupRealmDemo
//
//  Created by Nicholas Rose on 2/20/17.
//  Copyright © 2017 Slalom Consulting. All rights reserved.
//

import UIKit
import RealmSwift

class LocationModel: Object {
    dynamic var latitude: Float = 0.0
    dynamic var longitude:  Float = 0.0
}
