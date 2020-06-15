//  Smart Dubai
//
//  Created by Puneet kumar  on 15/06/20.
//  Copyright © 2020 Puneet Kumar. All rights reserved.
//

import UIKit
import Foundation

internal final class WeatherListService: APIResponseRepresentable {
    
    var networkClient:NetworkClient = NetworkClient()

    func getWheatherData<T: Codable>(_ params: [String:Any], requestCompletion: @escaping (_ object:T?,_ error: String?)->()){
        
        let request = URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(params["City"] ?? "London")&appid=28dea7ee395d1705160887d28aca3858")!)
        self.networkClient.loadRequest(request) { data, response, error in
            
            self.handleResponse(responseData: data, urlResponse: response, errorObj: error, completionHandler: { (_ object:T?, _ error: String?) in
                
                requestCompletion(object,error)
            })
        }
    }
    
    
    func getWheatherForecastData<T: Codable>(_ params: [String:Any], requestCompletion: @escaping (_ object:[T]?,_ error: String?)->()){
        
        let latutude  =  params["lat"]
        let longitude = params["long"]
        
        
        let request = URLRequest(url: URL(string:"https://api.openweathermap.org/data/2.5/forecast?lat=\(latutude!)&lon=\(longitude!)&appid=28dea7ee395d1705160887d28aca3858")!)
        self.networkClient.loadRequest(request) { data, response, error in
            
            self.handleResponse(responseData: data, urlResponse: response, errorObj: error, completionHandler: { (_ object:T?, _ error: String?) in
                
                requestCompletion([object!],error)
            })
        }
    }
    
    
    
}
