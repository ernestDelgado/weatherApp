//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Ernest Delgado on 6/28/17.
//  Copyright © 2017 Ernest Delgado. All rights reserved.
//

import UIKit
import Alamofire


class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String{
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String{
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double{
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completion: @escaping DownloadComplete) {
        //alamofire download
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        self._currentTemp = Double(round(10 * self.kevToFah(degree: currentTemperature)/10))
                    }
                }
            }
            print(response.result.value)
            completion()
        }
        
    }

    
    func kevToFah(degree: Double) -> Double{
        return degree * (9.0/5.0) - 459.67
    }
    
    
}
