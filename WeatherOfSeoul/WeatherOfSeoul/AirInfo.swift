//
//  AirInfo.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/23.
//

import Foundation
import UIKit

struct AirInfo {
    var grade: String
    var gradeToString: String
    var value: String
    var backgroundColor: UIColor
    var gradeDic: [String] = ["좋음", "보통", "나쁨", "매우나쁨"]
    var colorList: [UIColor] = [UIColor.colorWithRGBHex(hex: 0x50BCDF), UIColor.colorWithRGBHex(hex: 0x81C147), UIColor.yellow, UIColor.red]
    
    init(grade: String, value: String) {
        self.grade = grade
        self.gradeToString = gradeDic[(Int(grade) ?? 3) - 1]
        self.value = value
        self.backgroundColor = colorList[(Int(grade) ?? 1) - 1]
    }

}
