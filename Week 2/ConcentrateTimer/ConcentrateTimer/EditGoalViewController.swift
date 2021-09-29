//
//  EditGoalViewController.swift
//  ConcentrateTimer
//
//  Created by 권준상 on 2021/09/27.
//

import UIKit

class EditGoalViewController: UIViewController {

    @IBOutlet weak var editGoalNameTextField: UITextField!
    @IBOutlet weak var editGoalTimeTextField: UITextField!
    @IBOutlet weak var editConfirmButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var isGoalSetted: Bool = false
    
    let goalTimeTextFieldToolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.backgroundColor = .white
        toolbar.sizeToFit()
        return toolbar
    }()
    
    private var timePicker: UIDatePicker?
    static var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setValue()
        setTimePicker()
        registerToolbar()
        setButton()
    }
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        if !isGoalSetted {
            self.showAlert(message: "목표 수정하기를 취소하시겠습니까?", type: "choice")
        }
    }
    
    func setValue() {
        if let index = EditGoalViewController.index {
            editGoalNameTextField.text = appDelegate.goalList[index].goalName
            editGoalTimeTextField.text = appDelegate.goalList[index].goalTime
        }
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setTimePicker() {
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .countDownTimer
        editGoalTimeTextField.inputView = timePicker
        timePicker?.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    func setButton() {
        editConfirmButton.setTitleColor(.white, for: .normal)
        editConfirmButton.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0x80CB9F), for: .normal)
        editConfirmButton.clipsToBounds = true
        editConfirmButton.layer.cornerRadius = 8
        editConfirmButton.addTarget(self, action: #selector(saveGoal), for: .touchUpInside)
    }
    
    func registerToolbar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidTap))

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        goalTimeTextFieldToolBar.setItems([ flexibleSpace, doneButton], animated: false)
        goalTimeTextFieldToolBar.isUserInteractionEnabled = true
        editGoalTimeTextField.inputAccessoryView = goalTimeTextFieldToolBar
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
                editGoalTimeTextField.text = "00:01"
            } else {
                editGoalTimeTextField.text = dateFormatter.string(from: timepicker.date)
            }
        }
    }
    
    @objc func doneButtonDidTap() {
        dateChanged()
        editGoalTimeTextField.resignFirstResponder()
    }
    
    @objc func saveGoal() {
        guard self.editGoalNameTextField.text?.isEmpty == false else {
            self.showAlert(message: "목표의 이름을 설정해주세요", type: "confirm")
            return
        }
        
        guard self.editGoalTimeTextField.text?.isEmpty == false else {
            self.showAlert(message: "집중 시간을 설정해주세요", type: "confirm")
            return
        }
        
        guard EditGoalViewController.index != nil else {
            return
        }
        
        let data = GoalData(goalName: self.editGoalNameTextField.text!, goalTime: self.editGoalTimeTextField.text!)
        
        appDelegate.goalList.remove(at: EditGoalViewController.index!)
        appDelegate.goalList.insert(data, at: EditGoalViewController.index!)
        isGoalSetted = true
        EditGoalViewController.index = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
