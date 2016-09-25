//
//  NetworkingManager.swift
//  Test
//
//  Created by Peyman Halfmoon on 2016-09-24.
//  Copyright © 2016 TSL030. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingManager {
    static let sharedInstance: NetworkingManager = NetworkingManager()
    
    let weatherURL = ""
    
    let baseURL = "http://apidev.accuweather.com/"
    let apiKey = "HackuWeather2016"
    //call another thing for the location
    let location = "55488"  // Toronto 
//    let location = "334331" // Raining city
    
    // MARK: Helper
    func urlWithPath(path: String) -> String {
        return "\(baseURL)\(path)"
    }
    
    class DailyWeatherResponse {
        var hours: [HourResponse]?
        
        init(dailyWeatherResponseDictionary: AnyObject) {
            if let hoursArray = dailyWeatherResponseDictionary as? [AnyObject] {
                hours = []
                for hour in hoursArray {
                    if let hourDictionary = hour as? [String: AnyObject] {
                        let hourItem = HourResponse(hourDictionary: hourDictionary)
                        hours?.append(hourItem)
                    }
                }
            }
        }
        
        class HourResponse {
            var DateTime: String?
            var EpochDateTime: Int?
            var WeatherIcon: Int?
            var IconPhrase: String?
            var IsDaylight: Bool?
            var PrecipitationProbability: Int?
            var MobileLink: String?
            var Link: String?
            var temp: Temperature?
            
            
            init(hourDictionary: [String: AnyObject]) {
                if let DateTime = hourDictionary["DateTime"] as? String {
                    self.DateTime = DateTime
                }
                if let EpochDateTime = hourDictionary["EpochDateTime"] as? Int {
                    self.EpochDateTime = EpochDateTime
                }
                if let WeatherIcon = hourDictionary["WeatherIcon"] as? Int {
                    self.WeatherIcon = WeatherIcon
                }
                if let IconPhrase = hourDictionary["IconPhrase"] as? String {
                    self.IconPhrase = IconPhrase
                }
                if let IsDaylight = hourDictionary["IsDaylight"] as? Bool {
                    self.IsDaylight = IsDaylight
                }
                if let PrecipitationProbability = hourDictionary["PrecipitationProbability"] as? Int {
                    self.PrecipitationProbability = PrecipitationProbability
                }
                if let MobileLink = hourDictionary["MobileLink"] as? String {
                    self.MobileLink = MobileLink
                }
                if let Link = hourDictionary["Link"] as? String {
                    self.Link = Link
                }
                if let tempDictionary = hourDictionary["Temperature"] as? [String: AnyObject] {
                    self.temp = Temperature(temp: tempDictionary)
                }
            }
            
            class Temperature {
                var Value: Int?
                var Unit: String?
                var UnitType: Int?
                init(temp: [String: AnyObject]){
                    if let Value = temp["Value"] as? Int {
                        self.Value = Value
                    }
                    if let Unit = temp["Unit"] as? String {
                        self.Unit = Unit
                    }
                    if let UnitType = temp["UnitType"] as? Int {
                        self.UnitType = UnitType
                    }
                }
            }
        }
    }
    
    func performWeatherRequest( completion: @escaping(_ weatherObject: DailyWeatherResponse?) -> Void) {
        let urlString = self.urlWithPath(path: "forecasts/v1/hourly/24hour/\(location)?apikey=\(apiKey)&metric=true")
        
        if let url = URL(string: urlString) {
            Alamofire.request(url).responseJSON { (response) in
                let weatherResponse = DailyWeatherResponse(dailyWeatherResponseDictionary: response.result.value as AnyObject)
                completion(weatherResponse)
            }
        }
//        completion(nil)
    }
}
