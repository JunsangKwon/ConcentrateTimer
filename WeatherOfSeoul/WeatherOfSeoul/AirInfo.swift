//
//  AirInfo.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/23.
//

import Foundation

struct AirInfo {
    var grade: String
    var gradeToString: String
    var value: String
    var gradeDic: [String] = ["좋음", "보통", "나쁨", "매우나쁨"]
    
    init(grade: String, value: String) {
        self.grade = grade
        self.gradeToString = gradeDic[(Int(grade) ?? 3) - 1]
        self.value = value
    }

}
