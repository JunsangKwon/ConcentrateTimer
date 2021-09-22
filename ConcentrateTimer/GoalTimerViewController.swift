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
        setNotifications()
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
    static var count = 0
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
    
    func setNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(addbackGroundTime(_:)), name: NSNotification.Name("sceneWillEnterForeground"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(stopTimer), name: NSNotification.Name("sceneDidEnterBackground"), object: nil)
        
        }
    
    func showAlert(message: String, type: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        if type == "confirm" {
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
        } else {
            let actionNo = UIAlertAction(title: "아니요", style: .default, handler: nil)
            
            let actionYes = UIAlertAction(title: "예", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)

            })
            alert.addAction(actionYes)
            alert.addAction(actionNo)
        }
        
        present(alert, animated: true, completion: nil)
    }

    
    func calculateHourAndMiniute(time: String) {
        let hourAndMinute = time.split(separator: ":")
        GoalTimerViewController.count += Int(hourAndMinute[0])! * 3600
        GoalTimerViewController.count += Int(hourAndMinute[1])! * 60
        totalSecond = GoalTimerViewController.count
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
        GoalTimerViewController.count -= 1
        progress += 1
        let time = secondsToHoursMinutesSeconds(seconds: GoalTimerViewController.count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
        if GoalTimerViewController.count != 0 {
            DispatchQueue.main.async {
                self.progressBarView.setProgress(Float(self.progress) / Float(self.totalSecond), animated: true)
            }
        } else {
            showAlert(message: "집중 시간을 달성했어요!", type: "confirm")
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
    
    @objc func addbackGroundTime(_ notification:Notification) {
        let IntervalTime = notification.userInfo?["time"] as? Int ?? 0
        GoalTimerViewController.count -= IntervalTime
        progress += IntervalTime
        if GoalTimerViewController.count <= 0 {
            showAlert(message: "집중 시간을 달성했어요!", type: "confirm")
            timerLabel.text = "00:00:00"
            progressBarView.setProgress(1.0, animated: true)
            timer.invalidate()
            playStopButton.setTitle("종료", for: .normal)
            isFinish = true
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func stopTimer() {
        timer.invalidate()
    }

    
}
