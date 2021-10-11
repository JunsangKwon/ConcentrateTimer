//
//  ViewController.swift
//  AvoidStone
//
//  Created by 권준상 on 2021/10/06.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var greatScoreLabel: UILabel!
    @IBOutlet weak var presentScoreLabel: UILabel!
    @IBOutlet weak var goLeftButton: UIButton!
    @IBOutlet weak var goRightButton: UIButton!
    @IBOutlet weak var manImageView: UIImageView!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet weak var gameOverScoreLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var manConstraints: NSLayoutConstraint!
    
    var scoreTimer = Timer()
    var rockTimer = Timer()
    var countDownTimer = Timer()
    var count = 3
    var presentScore = 0
    var highestScore = UserDefaults.standard.integer(forKey: GameViewController.scoreKey)
    var isPlaying = false
    static let scoreKey = "score"
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    @IBAction func goLeftButtonTap(_ sender: Any) {
        goLeft()
    }
    
    @IBAction func goRightButtonTap(_ sender: Any) {
        goRight()
    }
    
    // 게임 시작 전 세팅
    func setView() {
        gameOverView.isHidden = true
        gameOverView.alpha = 0.0
        presentScoreLabel.text = String(0)
        greatScoreLabel.text = String(highestScore)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(scoreTimerCounter), userInfo: nil, repeats: true)
        rockTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(rockTimerCounter), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    func setRockImageView() {
        let randomValue1 = Int.random(in: 0..<Int(UIScreen.main.bounds.width)-50)
        
        let rockImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "rock")
            imageView.frame = CGRect(x: randomValue1 ,y: 0, width: 50, height: 50)
            return imageView
        }()
        
        self.view.addSubview(rockImageView)
        
        // MARK: 돌 내려가는 애니메이션
        UIView.animate(withDuration: 2.5, delay: 0, options: .allowUserInteraction, animations: {
            rockImageView.frame = CGRect(x: rockImageView.frame.minX, y: UIScreen.main.bounds.height - 130, width: 50, height: 50)
        }, completion: { _ in
            rockImageView.removeFromSuperview()
        })
        

        // MARK: 충돌 판정
        DispatchQueue.global(qos: .userInteractive).async {
            usleep(1800000)
            DispatchQueue.main.async {
                if (rockImageView.frame.maxX > self.manImageView.frame.minX + 20) && (rockImageView.frame.minX < self.manImageView.frame.maxX - 20) {
                    if (rockImageView.frame.minY <=
                            self.manImageView.frame.maxY) && self.isPlaying {
                        self.isPlaying = false
                        self.scoreTimer.invalidate()
                        self.rockTimer.invalidate()
                        if self.highestScore < self.presentScore {
                            UserDefaults.standard.setValue(self.presentScore, forKey: GameViewController.scoreKey)
                            self.highestScore = self.presentScore
                        }
                        self.setGameOverView()
                    }
                }
            }
        }
    }
    
    func goLeft() {
        if self.manConstraints.constant >= 10 {
            self.manConstraints.constant -= 30
        }
    }
    
    func goRight() {
        if self.manConstraints.constant <= UIScreen.main.bounds.width - self.manImageView.bounds.width {
            self.manConstraints.constant += 30
        }
    }
    
    func setGameOverView() {
        gameOverView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: { self.gameOverView.alpha = 1.0 }, completion: nil)
        gameOverScoreLabel.text = "\(presentScore)"
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
    }
    
    @objc func restartGame() {
        greatScoreLabel.text = String(UserDefaults.standard.integer(forKey: GameViewController.scoreKey))
        presentScore = 0
        countDownTimer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(self.countDownTimerCounter), userInfo: nil, repeats: true)
        countDownLabel.alpha = 1.0
        count = 3
        countDownLabel.text = "\(self.count)"
        gameOverView.isHidden = true
    }

    @objc func scoreTimerCounter() -> Void {
        presentScore += 1
        presentScoreLabel.text = String(presentScore)
    }
    
    @objc func rockTimerCounter() -> Void {
        setRockImageView()
    }
    
    @objc func countDownTimerCounter() -> Void {
        if count <= 0 {
            self.countDownLabel.alpha = 0.0
            countDownTimer.invalidate()
            setView()
        } else {
            count -= 1
            if count == 0 {
                countDownLabel.text = "START"
            } else {
                countDownLabel.text = "\(self.count)"
            }
        }
    }

}

