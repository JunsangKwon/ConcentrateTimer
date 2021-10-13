//
//  SignInViewController.swift
//  WeatherOfSeoul
//
//  Created by 권준상 on 2021/10/13.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin

class SignInViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginInstance?.delegate = self
    }
    
    @IBAction func kakaoSignInButtonDidTap(_ sender: Any) {
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
    
    @IBAction func naverSignInButtonDidTap(_ sender: Any) {
        loginInstance?.requestThirdPartyLogin()
    }
    
}

extension SignInViewController: NaverThirdPartyLoginConnectionDelegate {
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success Naver login")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let weatherVC = storyboard.instantiateViewController(withIdentifier: "WeatherVC")
        weatherVC.modalPresentationStyle = .fullScreen

        self.present(weatherVC, animated: false, completion: nil)
    }

    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.accessToken
    }

    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }

    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print(error.localizedDescription)
    }
}



