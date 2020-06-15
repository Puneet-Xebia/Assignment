//  Smart Dubai
//
//  Created by Puneet kumar  on 15/06/20.
//  Copyright © 2020 Puneet Kumar. All rights reserved.
//

import UIKit

struct Weather : Codable {
    
    var weather: [weather]?
    var main = Main()
    var wind = Wind()

}

struct WeatherForeCast : Codable {
    
    var list : [List]?

}

struct List : Codable {
    
    var main = Main()
    var wind = Wind()
    var weather: [weather]?

    
}


struct weather : Codable {
    
    var weatherDec : String?
    
    private enum CodingKeys: String, CodingKey {
        case weatherDec = "description"
    }
}

struct Main : Codable {
    
    var minTemperature: Float?
    var maxTemperature: Float?
    
    private enum CodingKeys: String, CodingKey {
        case minTemperature = "temp_min"
        case maxTemperature  = "temp_max"
    }
}

struct Wind : Codable {
    
    var windSpeed: Float?
    
    private enum CodingKeys: String, CodingKey {
        case windSpeed = "speed"
    }
}
