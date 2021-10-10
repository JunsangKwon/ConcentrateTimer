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
    @IBOutlet weak var manConstraints: NSLayoutConstraint!
    
    var scoreTimer = Timer()
    var rockTimer = Timer()
    var presentScore = 0
    var highestScore = UserDefaults.standard.integer(forKey: GameViewController.scoreKey)
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
        print(highestScore)
        presentScoreLabel.text = String(0)
        greatScoreLabel.text = String(highestScore)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(scoreTimerCounter), userInfo: nil, repeats: true)
        rockTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(rockTimerCounter), userInfo: nil, repeats: true)
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

        // MARK: 충돌 판정 (오류 있음)
        DispatchQueue.main.async {
            if (rockImageView.frame.maxX > self.manImageView.frame.minX) && (rockImageView.frame.minX < self.manImageView.frame.maxX) {
                if rockImageView.frame.minY <=
                    self.manImageView.frame.maxY {
                    self.scoreTimer.invalidate()
                    self.rockTimer.invalidate()
                    self.showAlert()
                    if self.highestScore < self.presentScore {
                        UserDefaults.standard.setValue(self.presentScore, forKey: GameViewController.scoreKey)
                        self.highestScore = self.presentScore
                    }
                    self.greatScoreLabel.text = String(UserDefaults.standard.integer(forKey: GameViewController.scoreKey)) 
                    self.presentScore = 0
                }
            }
        }
                
        
        // MARK: 돌 내려가는 애니메이션
        UIView.animate(withDuration: 2.5, delay: 0, options: .allowUserInteraction, animations: {
            rockImageView.frame = CGRect(x: rockImageView.frame.minX, y: UIScreen.main.bounds.height - 130, width: 50, height: 50)
        }, completion: { _ in
            rockImageView.removeFromSuperview()
        })
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
    
    func showAlert() {
        let alert = UIAlertController(title: "게임 오버!", message: "당신의 점수는 \(self.presentScore)", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "재시작", style: .default, handler: { _ in
                self.setView()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }

    @objc func scoreTimerCounter() -> Void {
        presentScore += 1
        presentScoreLabel.text = String(presentScore)
    }
    
    @objc func rockTimerCounter() -> Void {
        setRockImageView()
    }

}

