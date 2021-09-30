//
//  MainViewController.swift
//  QuestionDiary
//
//  Created by 권준상 on 2021/09/29.
//

import UIKit

class MainViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var isSelect = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setButton()
        initIsLikeButtonTouched()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailDiaryViewController
            if let row = sender as? DiaryData {
                vc?.diaryData = row
            }
        }
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
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func initIsLikeButtonTouched() {
        for _ in 0..<appDelegate.diarylist.count {
            appDelegate.isLikeButtonTouched.append(false)
        }
    }
    
    @objc func likeButtonDidTap(sender: UIButton) {
        if !isSelect {
            sender.isSelected = true
            isSelect = true
        } else {
            sender.isSelected = false
            isSelect = false
        }
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.diarylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else {
            return UITableViewCell()
        }
        
        let row = self.appDelegate.diarylist[indexPath.row]
        
        cell.titleLabel.text = row.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        cell.regdateLabel.text = formatter.string(from: row.regdate)
        cell.likeButton.isSelected = appDelegate.isLikeButtonTouched[indexPath.row]
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.appDelegate.diarylist[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: row)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DiaryCell {
            appDelegate.isLikeButtonTouched[indexPath.row] = cell.likeButton.isSelected
        }
    }
}
