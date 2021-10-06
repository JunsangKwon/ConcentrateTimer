//
//  ViewController.swift
//  AvoidStone
//
//  Created by 권준상 on 2021/10/06.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var greatScore: UILabel!
    @IBOutlet weak var presentScore: UILabel!
    @IBOutlet weak var goLeftButton: UIButton!
    @IBOutlet weak var goRightButton: UIButton!
    @IBOutlet weak var manImageView: UIImageView!
    @IBOutlet weak var manConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goLeftButtonTap(_ sender: Any) {
        goLeft()
    }
    
    @IBAction func goRightButtonTap(_ sender: Any) {
        goRight()
    }
    
    func goLeft() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .allowUserInteraction, animations: {
            if self.manConstraints.constant >= 10 {
                self.manConstraints.constant -= 30
            }
        }, completion: nil)
    }
    
    func goRight() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .allowUserInteraction, animations: {
            if self.manConstraints.constant <= UIScreen.main.bounds.width - self.manImageView.bounds.width {
                self.manConstraints.constant += 30
            }
        }, completion: nil)
    }
    


}

