//
//  ViewController.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/12.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var presentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var textDataDic: [String : String] = ["Clear" : "sunny", "Clouds" :  "cloud", "Rain" : "rain", "Snow" : "snow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherStatusLabel.text = " "
        presentTempLabel.text = " "
        maxTempLabel.text = " "
        minTempLabel.text = " "
        WeatherRequest().getWeatherData(self)
        WeatherRequest().getAirPollutionData(self)
    }


}

extension WeatherViewController {
    func didWeatherAPISuccess(_ response: WeatherEntity) {
        weatherStatusLabel.text = response.weather[0].main
        weatherImageView.image = UIImage(named: textDataDic[response.weather[0].main] ?? "question")
        presentTempLabel.text = "\(Int(response.main.temp-273))°"
        maxTempLabel.text = "\(Int(response.main.temp_max-273))°"
        minTempLabel.text = "\(Int(response.main.temp_min-273))°"
    }
    
    func didWeatherAPIFailure() {
        weatherStatusLabel.text = "?"
        weatherImageView.image = UIImage(named: "question")
        presentTempLabel.text = "?"
        maxTempLabel.text = "?"
        minTempLabel.text = "?"
    }
    
    func didAirPollutionAPISuccess(_ response: AirPollutionEntity) {
        appDelegate.airInfoList.append(AirInfo(grade: response.response.body.items?[0].pm10Grade ?? "", value: response.response.body.items?[0].pm10Value ?? ""))
        appDelegate.airInfoList.append(AirInfo(grade: response.response.body.items?[0].pm25Grade ?? "", value: response.response.body.items?[0].pm25Value ?? ""))
        appDelegate.airInfoList.append(AirInfo(grade: response.response.body.items?[0].no2Grade ?? "", value: response.response.body.items?[0].no2Value ?? ""))
        appDelegate.airInfoList.append(AirInfo(grade: response.response.body.items?[0].o3Grade ?? "", value: response.response.body.items?[0].o3Value ?? ""))
        appDelegate.airInfoList.append(AirInfo(grade: response.response.body.items?[0].coGrade ?? "", value: response.response.body.items?[0].coValue ?? ""))
        appDelegate.airInfoList.append(AirInfo(grade: response.response.body.items?[0].so2Grade ?? "", value: response.response.body.items?[0].so2Value ?? ""))
        self.collectionView.reloadData()
    }

}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.airInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AirInfoCell", for: indexPath) as? AirInfoCell
        else {
            return UICollectionViewCell()
        }
        
        let row = self.appDelegate.airInfoList[indexPath.item]
        cell.infoTitleLabel.text = cell.infoTitleList[indexPath.item]
        cell.infoStatusLabel.text = row.gradeToString
        cell.infoLabel.text = row.value
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemspacing: CGFloat = 3
        let width: CGFloat = (collectionView.bounds.width/3)-itemspacing*3
        let height: CGFloat = width + 20
        return CGSize(width: width, height: height)
    }
}
