//
//  SignInViewController.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/13.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class SignInViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButtonDIdTap(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
            print("loginWithKakaoAccount() success.")
            _ = oauthToken
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let weatherVC = storyboard.instantiateViewController(withIdentifier: "WeatherVC")
            weatherVC.modalPresentationStyle = .fullScreen

            self.present(weatherVC, animated: false, completion: nil)
           }
        }
    }
    

}
