//  Smart Dubai
//
//  Created by Puneet kumar  on 15/06/20.
//  Copyright © 2020 Puneet Kumar. All rights reserved.
//

import UIKit

internal final class WeatherViewModel {
    
    
    var weatherList = Weather()


    
    var albumService:WeatherListService = WeatherListService()
    
    var weatherArray : [Weather] = []
    var WeatherForeCastArray : [List] = []
    var weatherForecast = WeatherForeCast()

    
    init() {
    }
    
    
    func getWheaterData(strCityName:String,completionHandler:@escaping ((Weather?,String?) -> ())) {
         
        let someDic = ["City":strCityName]
        
        self.albumService.getWheatherData(someDic) {  (_ object:Weather?, _ error:String?) in
            if let results = object{
                
                self.weatherList = results
                self.weatherArray.append(self.weatherList)

            }
            completionHandler(object,error);
        }
    }
    
    func getForeCastWheaterData(Lat:Double,Long:Double,completionHandler:@escaping (() -> ())) {
           
          let someDic = ["lat":Lat,"long":Long]

          
          self.albumService.getWheatherForecastData(someDic) {  (_ object:[WeatherForeCast]?, _ error:String?) in
              guard let results = object else {
                        return;
                    }
            if(results.count>0)
                {
                    self.weatherForecast = results[0]
                    self.WeatherForeCastArray =  self.weatherForecast.list!
              }
            
              completionHandler()
      }
        
    }
    
    
    var noOfRows:Int {
        
        return self.weatherArray.count
     }
    
    var noOfForeCastRows:Int {
         
         return self.WeatherForeCastArray.count
      }
    
    
    func forecastWeatherAtIndex(index:Int) -> List
      {
          let weatherData = self.WeatherForeCastArray[index]
          return weatherData
      }
    
    
    func weatherAtIndex(index:Int) -> Weather
    {
        let weatherData = self.weatherArray[index]
        return weatherData
    }
}

