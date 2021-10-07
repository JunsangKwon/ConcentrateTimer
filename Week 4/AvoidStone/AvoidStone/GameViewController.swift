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
        presentScoreLabel.text = String(0)
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
        
        UIView.animate(withDuration: 2.5, delay: 0, options: .allowUserInteraction, animations: {
            rockImageView.center.y = UIScreen.main.bounds.height - 130
        }, completion: { _ in
            rockImageView.removeFromSuperview()
        })

    }
    
//    if (rockImageView.center.x > self.manImageView.center.x - 40) && (rockImageView.center.x < self.manImageView.center.x + 40) {
//        if rockImageView.center.y < self.manImageView.center.y {
//            self.scoreTimer.invalidate()
//            self.rockTimer.invalidate()
//            self.showAlert()
//        }
//    }
    
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

