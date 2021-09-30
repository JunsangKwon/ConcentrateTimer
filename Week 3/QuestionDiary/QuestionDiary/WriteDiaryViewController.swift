//
//  WriteDiaryViewController.swift
//  QuestionDiary
//
//  Created by 권준상 on 2021/09/29.
//

import UIKit

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var todaysQuestion: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var questionList : [String] = ["오늘의 TMI는?", "오늘의 패션 컨셉은?", "오늘 점심메뉴는?", "오늘 제일 걱정이었던 점은?", "오늘의 최고지출은 뭔가요?", "오늘의 소확행은?", "오늘 제일 화나는 점은?", "오늘을 색으로 표현하자면?", "오늘 제일 좋았던 일은?", "지금 당신의 기분은?"]
    
    @IBAction func saveDiary(_ sender: Any) {
        guard self.titleTextField.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "제목을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard self.contentTextView.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let data = DiaryData(title: self.titleTextField.text!, contents: self.contentTextView.text, regdate: Date())

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.diarylist.append(data)
        appDelegate.isLikeButtonTouched.append(false)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestion()
        setAnimation()
        setTodayDate()
        placeholderSetting()
    }
    
    func setQuestion() {
        let num = Int.random(in: 0..<10)
        todaysQuestion.text = questionList[num]
        todaysQuestion.alpha = 0.0
    }
    
    func setAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseIn, animations: { self.todaysQuestion.alpha = 1.0 }, completion: nil)

    }
    
    func setTodayDate() {
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        todayDateLabel.text = formatter.string(from: todayDate)
    }
    
    func placeholderSetting() {
        contentTextView.delegate = self
        contentTextView.text = "오늘 하루를 기록해보세요!"
        contentTextView.textColor = UIColor.lightGray
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
      if contentTextView.textColor == UIColor.lightGray {
        contentTextView.text = nil
        contentTextView.textColor = UIColor.black
      }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
      if contentTextView.text.isEmpty {
        contentTextView.text = "오늘 하루를 기록해보세요!"
        contentTextView.textColor = UIColor.lightGray
      }
    }
}
