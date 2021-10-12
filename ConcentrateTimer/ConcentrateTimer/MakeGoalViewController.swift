//
//  MakeGoalViewController.swift
//  ConcentrateTimer
//
//  Created by 권준상 on 2021/09/15.
//

import UIKit

class MakeGoalViewController: UIViewController {

    @IBOutlet weak var goalNameTextField: UITextField!
    
    @IBOutlet weak var goalTimeTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    var isGoalSetted: Bool = false
    
    let goalTimeTextFieldToolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.backgroundColor = .white
        toolbar.sizeToFit()
        return toolbar
    }()
    
    private var timePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTimePicker()
        registerToolbar()
        setButton()
    }
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        if !isGoalSetted {
            self.showAlert(message: "목표 만들기를 취소하시겠습니까?", type: "choice")
        }
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setTimePicker() {
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .countDownTimer
        goalTimeTextField.inputView = timePicker
        timePicker?.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    func setButton() {
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0x80CB9F), for: .normal)
        confirmButton.clipsToBounds = true
        confirmButton.layer.cornerRadius = 8
        confirmButton.addTarget(self, action: #selector(saveGoal), for: .touchUpInside)
    }
    
    func registerToolbar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidTap))

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        goalTimeTextFieldToolBar.setItems([ flexibleSpace, doneButton], animated: false)
        goalTimeTextFieldToolBar.isUserInteractionEnabled = true
        goalTimeTextField.inputAccessoryView = goalTimeTextFieldToolBar
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
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let timepicker = timePicker {
            if dateFormatter.string(from: timepicker.date) == "00:00" {
                goalTimeTextField.text = "00:01"
            } else {
                goalTimeTextField.text = dateFormatter.string(from: timepicker.date)
            }
        }
    }
    
    @objc func doneButtonDidTap() {
        dateChanged()
        goalTimeTextField.resignFirstResponder()
    }
    
    @objc func saveGoal() {
        guard self.goalNameTextField.text?.isEmpty == false else {
            self.showAlert(message: "목표의 이름을 설정해주세요", type: "confirm")
            return
        }
        
        guard self.goalTimeTextField.text?.isEmpty == false else {
            self.showAlert(message: "집중 시간을 설정해주세요", type: "confirm")
            return
        }
        
        let data = GoalData(goalName: self.goalNameTextField.text!, goalTime: self.goalTimeTextField.text!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.goalList.append(data)
        isGoalSetted = true
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
