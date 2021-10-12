//
//  DetailDiaryViewController.swift
//  QuestionDiary
//
//  Created by 권준상 on 2021/09/30.
//

import UIKit

class DetailDiaryViewController: UIViewController {
    
    var diaryData: DiaryData?
    @IBOutlet weak var diaryDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
    }
    
    func setValue() {
        if let diarydata = diaryData {
            navigationItem.title = diarydata.title
            titleLabel.text = diarydata.title
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
            diaryDateLabel.text = formatter.string(from: diarydata.regdate)
            contentTextView.text = diarydata.contents
            contentTextView.isEditable = false
        }
    }
}
