//
//  GoalTimerViewController.swift
//  ConcentrateTimer
//
//  Created by 권준상 on 2021/09/17.
//

import UIKit

class GoalTimerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setProgressView()
        setTimerLabel()
        setNavigationBar()
        setPlayStopButton()
    }

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var playStopButton: UIButton!
    
    @IBAction func dismissButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var goalData: GoalData?
    var timer: Timer = Timer()
    var timerCounting: Bool = false
    var isFinish: Bool = false
    var count = 0
    var totalSecond = 0
    var progress = 0
    
    func setTimerLabel() {
        if let time = goalData?.goalTime {
            timerLabel.text = time + ":00"
            calculateHourAndMiniute(time: time)
        }
    }
    
    func setProgressView() {
        progressBarView.layer.cornerRadius = 8
        progressBarView.clipsToBounds = true
        progressBarView.layer.sublayers![1].cornerRadius = 8
        progressBarView.subviews[1].clipsToBounds = true
        progressBarView.progress = 0.0
    }
    
    func setPlayStopButton() {
        playStopButton.setTitleColor(.white, for: .normal)
        playStopButton.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0x80CB9F), for: .normal)
        playStopButton.clipsToBounds = true
        playStopButton.layer.cornerRadius = 8
    }
    
    func calculateHourAndMiniute(time: String) {
        let hourAndMinute = time.split(separator: ":")
        count += Int(hourAndMinute[0])! * 3600
        count += Int(hourAndMinute[1])! * 60
        totalSecond = count
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        if let name = goalData?.goalName {
            self.navigationItem.title = name
        }
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func playStopButtonDidTap(_ sender: Any) {
        if isFinish {
            self.navigationController?.popViewController(animated: true)
        } else if timerCounting {
            timerCounting = false
            timer.invalidate()
            playStopButton.setTitle("계속", for: .normal)
        } else {
            timerCounting = true
            playStopButton.setTitle("일시정지", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count - 1
        progress += 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
        if count != 0 {
            DispatchQueue.main.async {
                self.progressBarView.setProgress(Float(self.progress) / Float(self.totalSecond), animated: true)
            }
        } else {
            timer.invalidate()
            playStopButton.setTitle("종료", for: .normal)
            isFinish = true
        }
        
        
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        return String(format:"%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}
