//
//  CurrientWeather.swift
//  WeatherBroadcast
//
//  Created by Roman Kochnev on 02.03.2018.
//  Copyright © 2018 Roman Kochnev. All rights reserved.
//

import Foundation
import UIKit

struct CurrientWeather {
    let temperature: Double
    let appearentTemperature: Double
    let wet: Double
    let pressure: Double
    let icon: UIImage
}

extension CurrientWeather: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
        let appearentTemperature = JSON["apparentTemperature"] as? Double,
        let wet = JSON["humidity"] as? Double,
        let pressure = JSON["pressure"] as? Double,
            let iconString = JSON["icon"] as? String else {
                return nil
        }
        
        let icon = WeatherIconManager(rawValue: iconString).image
        
        self.temperature = temperature
        self.appearentTemperature = appearentTemperature
        self.wet = wet
        self.pressure = pressure
        self.icon = icon
    }
}

extension CurrientWeather {
    var pressureString: String {
        return "\(Int(pressure * 0.750062)) mm"
    }
    
    var wetString: String {
        return "\(Int(wet * 100)) %"
    }
    
    var temperatureString: String {
        return "\(Int(5 / 9 * (temperature - 32)))˚C"
    }
    
    var appearentTemperatureString: String {
        return "\(Int(5 / 9 * (appearentTemperature - 32)))˚C"
    }
}
