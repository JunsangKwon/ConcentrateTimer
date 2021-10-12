//
//  ViewController.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/12.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var presentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var textDataDic: [String : String] = ["Clear" : "sunny", "Clouds" :  "cloud", "Rain" : "rain", "Snow" : "snow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherStatusLabel.text = ""
        presentTempLabel.text = ""
        maxTempLabel.text = ""
        minTempLabel.text = ""
        WeatherRequest().getWeatherData(self)
    }


}

extension WeatherViewController {
    func didSuccess(_ response: WeatherEntity) {
        weatherStatusLabel.text = response.weather[0].main
        weatherImageView.image = UIImage(named: textDataDic[response.weather[0].main] ?? "question")
        presentTempLabel.text = "\(Int(response.main.temp-273))°"
        maxTempLabel.text = "\(Int(response.main.temp_max-273))°"
        minTempLabel.text = "\(Int(response.main.temp_min-273))°"
    }
    
    func didFailure() {
        weatherStatusLabel.text = "?"
        weatherImageView.image = UIImage(named: "question")
        presentTempLabel.text = "?"
        maxTempLabel.text = "?"
        minTempLabel.text = "?"
    }
}
