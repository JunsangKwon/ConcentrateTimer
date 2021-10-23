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
                    viewController.didWeatherAPISuccess(response)
                case .failure(let error):
                    viewController.didWeatherAPIFailure()
                    print(error.localizedDescription)
                }

        }
    }
    
    func getAirPollutionData(_ viewController: WeatherViewController) {
        let url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"
        let params: Parameters = [
            "serviceKey": "LK9dzzD%2B%2F1hZq1vRVsA0Cy8CUTcZq9%2BzcgAv48NJJfmZS3WDZzQMCuxzYmm%2Bbuu4wKEO139LErounXszCYBSAA%3D%3D",
            "returnType": "json",
            "numOfRows": "1",
            "pageNo": "1",
            "stationName": "종로구",
            "dataTerm": "DAILY",
            "ver": "1.0"
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: nil)
            .responseDecodable(of: AirPollutionEntity.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.didAirPollutionAPISuccess(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }

        }
    }
}
