//
//  WeatherEntity.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/13.
//

import Foundation

struct WeatherEntity: Decodable {
    
    var coord: CoordinateResponse
    var weather: [WeatherResponse]
    var base: String
    var main: MainResponse
    var visibility: Int
    var wind: WindResponse
    var clouds: CloudResponse
    var dt: Int
    var sys: SysResponse
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
}

struct CoordinateResponse: Decodable {
    var lon: Float
    var lat: Float
}

struct WeatherResponse: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct MainResponse: Decodable {
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var pressure: Float
    var humidity: Float
}

struct WindResponse: Decodable {
    var speed: Float
    var deg: Int
}

struct CloudResponse: Decodable {
    var all: Int
}

struct SysResponse: Decodable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
}
