//
//  AirInfoCell.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/23.
//

import UIKit

class AirInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoStatusLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    var infoTitleList = ["미세먼지", "초미세먼지", "이산화질소", "오존", "일산화탄소", "아황산가스"]
}
