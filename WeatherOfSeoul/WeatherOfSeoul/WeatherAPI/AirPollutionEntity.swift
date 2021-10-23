//
//  AirPollutionEntity.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/22.
//

import Foundation

struct AirPollutionEntity: Decodable {
    var response: AirPollutionResponse
}

struct AirPollutionResponse: Decodable {
    var body: ResponseBody
    var header: ResponseHeader
}

struct ResponseBody: Decodable {
    var totalCount: Int?
    var items: [PollutionData]?
    var pageNo: Int?
    var numOfRows: Int?
}

struct PollutionData: Decodable {
    var so2Grade: String?
    var coFlag: String?
    var khaiValue: String?
    var so2Value: String?
    var coValue: String?
    var pm25Flag: String?
    var pm10Flag: String?
    var pm10Value: String?
    var o3Grade: String?
    var khaiGrade: String?
    var pm25Value: String?
    var no2Flag: String?
    var no2Grade: String?
    var o3Flag: String?
    var pm25Grade: String?
    var so2Flag: String?
    var dataTime: String?
    var coGrade: String?
    var no2Value: String?
    var pm10Grade: String?
    var o3Value: String?
}

struct ResponseHeader: Decodable {
    var resultMsg: String?
    var resultCode: String?
}
