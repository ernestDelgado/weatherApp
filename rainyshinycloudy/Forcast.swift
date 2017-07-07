//
//  Forcast.swift
//  rainyshinycloudy
//
//  Created by Ernest Delgado on 7/5/17.
//  Copyright © 2017 Ernest Delgado. All rights reserved.
//

import UIKit

class Forcast {
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    var date: String{
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String{
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String{
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>){
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                _lowTemp =  "\(Double(round(10 * self.kevToFah(degree: min)/10)))"
            }
            
            if let max = temp["max"] as? Double{
                _highTemp =  "\(Double(round(10 * self.kevToFah(degree: max)/10)))"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                _weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "EEEE"
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
    func kevToFah(degree: Double) -> Double{
        return degree * (9.0/5.0) - 459.67
    }
    
}

extension Date{
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
