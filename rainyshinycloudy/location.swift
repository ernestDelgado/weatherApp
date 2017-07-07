//
//  location.swift
//  rainyshinycloudy
//
//  Created by Ernest Delgado on 7/6/17.
//  Copyright © 2017 Ernest Delgado. All rights reserved.
//

import CoreLocation

class Location {
 
    static var sharedInstance = Location()
    private init(){
        
    }
    var latitude: Double!
    var longitude: Double!
    
}
