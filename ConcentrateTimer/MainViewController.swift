//
//  ViewController.swift
//  ConcentrateTimer
//
//  Created by 권준상 on 2021/09/15.
//

import UIKit

class MainViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
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
