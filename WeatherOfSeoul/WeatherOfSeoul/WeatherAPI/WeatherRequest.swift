//
//  WeatherRequest.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/13.
//

import Alamofire
import UIKit

class WeatherRequest {
    
    func getWeatherData(_ viewController: WeatherViewController) {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let params: Parameters = [
            "q": "seoul",
            "appid": "ced6196732a06c7485c1feb058bc28c1"
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: nil)
            .responseDecodable(of: WeatherEntity.self) { response in
            
                switch response.result {
                case .success(let response):
                    viewController.didSuccess(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }

        }
    }
}
