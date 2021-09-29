//
//  MainViewController.swift
//  QuestionDiary
//
//  Created by 권준상 on 2021/09/29.
//

import UIKit

class MainViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func goToWriteDiaryViewController(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setXibCell()
        setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func setXibCell() {
        let nibName = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    func setButton() {
        writeButton.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0xFF9500), for: .normal)
        writeButton.layer.cornerRadius = writeButton.frame.width/2
        writeButton.clipsToBounds = true
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = containerView.frame.width/2
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowColor = UIColor.black.cgColor
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.diarylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}
