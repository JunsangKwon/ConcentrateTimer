//
//  ViewController.swift
//  ConcentrateTimer
//
//  Created by 권준상 on 2021/09/15.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setLongPressGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTimer" {
            let vc = segue.destination as? GoalTimerViewController
            if let row = sender as? GoalData {
                vc?.goalData = row
            }
        }
    }

    func setNavigationBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setLongPressGesture() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
            longPressedGesture.minimumPressDuration = 0.5
            longPressedGesture.delegate = self
            longPressedGesture.delaysTouchesBegan = true
            collectionView?.addGestureRecognizer(longPressedGesture)
    }
    
    func showAlert(message: String, position: CGPoint) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let actionDelete = UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            
            if let indexPath = self.collectionView?.indexPathForItem(at: position) {
                self.appDelegate.goalList.remove(at: indexPath.item)
                self.collectionView.reloadData()
            }
        })
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }
        let p = gestureRecognizer.location(in: self.collectionView)

        showAlert(message: "목표를 삭제 하시겠습니까?", position: p)
    }

    

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60 , height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appDelegate.goalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalCell", for: indexPath) as? GoalCell
        else {
            return UICollectionViewCell()
        }
        
        let row = self.appDelegate.goalList[indexPath.item]
        cell.goalNameLabel.text = row.goalName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = self.appDelegate.goalList[indexPath.item]
        performSegue(withIdentifier: "showTimer", sender: row)
    }
    
    
}
