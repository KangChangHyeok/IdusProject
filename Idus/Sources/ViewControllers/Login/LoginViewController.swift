//
//  SplashViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/26.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var imageView: UIView! {
        didSet {
            imageView.backgroundColor = .LoginViewImageBackgroundColor
            imageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var dotLine: UIView! {
        didSet {
            dotLine.createDottedLine(width: 3.0, color: UIColor.white.cgColor)
        }
    }
    @IBOutlet weak var kakaoSignUpButton: UIButton! {
        didSet {
            kakaoSignUpButton.backgroundColor = .kakaoYellowColor
            kakaoSignUpButton.layer.cornerRadius = kakaoSignUpButton.frame.height / 2
            kakaoSignUpButton.tintColor = .kakaoFontColor
        }
    }
    @IBOutlet weak var otherSignUpButton: UIButton!
    @IBOutlet weak var existUserLoginButton: UIButton! {
        didSet {
            existUserLoginButton.layer.borderWidth = 2
            existUserLoginButton.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
            existUserLoginButton.layer.cornerRadius = existUserLoginButton.frame.height / 2
            appleUserLoginButton.layer.cornerRadius = appleUserLoginButton.frame.height / 2
        }
    }
    @IBOutlet weak var appleUserLoginButton: UIButton!
    @IBOutlet weak var noSignUpButton: UIButton!
    @IBOutlet weak var background: UIImageView! {
        didSet {
            background.image = backgroundImages.randomElement() as? UIImage
        }
    }
    
    let backgroundImages = [UIImage(named: "1.jpg"), UIImage(named: "2.jpg"), UIImage(named: "3.jpg"), UIImage(named: "4.jpg")]
    
    //MARK: - override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValue()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeBackgroundImageAnimation()
    }
    
    //MARK: -function
    
    func setupValue() {
        
    }
    
    func changeBackgroundImageAnimation() {
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { timer in
            UIView.transition(with: self.background, duration: 3, options: .transitionCrossDissolve, animations: {
                self.background.image = self.backgroundImages.randomElement() as? UIImage
            }, completion: nil)
        })
    }
    //MARK: - IBAction
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
            
            //MARK: - 카카오로 3초만에 시작하기
            
        case kakaoSignUpButton:
            let kakaoSignUpVC = self.storyboard?.instantiateViewController(withIdentifier: "KakaoSignUpViewController") as! KakaoSignUpViewController
            kakaoSignUpVC.modalTransitionStyle = .crossDissolve
            kakaoSignUpVC.modalPresentationStyle = .overFullScreen
            kakaoSignUpVC.backgroundImage = background.image
            self.present(kakaoSignUpVC, animated: true, completion: nil)
            
            //MARK: - 다른 방법으로 가입하기
            
        case otherSignUpButton:
            let actionSheet = UIAlertController(title: "다른 방법으로 가입하기", message: nil, preferredStyle: .actionSheet)
            
            let naver = UIAlertAction(title: "네이버", style: .default)
            let facebook = UIAlertAction(title: "페이스북", style: .default)
            let twiter = UIAlertAction(title: "트위터", style: .default)
            let email = UIAlertAction(title: "이메일", style: .default) { _ in
                let EmailSignUpVC = self.storyboard?.instantiateViewController(identifier: "EmailSignUpViewController") as! EmailSignUpViewController
                EmailSignUpVC.modalTransitionStyle = .crossDissolve
                EmailSignUpVC.modalPresentationStyle = .overFullScreen
                EmailSignUpVC.backgroundImage = self.background.image
                self.present(EmailSignUpVC, animated: true)
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            actionSheet.addAction(naver)
            actionSheet.addAction(facebook)
            actionSheet.addAction(twiter)
            actionSheet.addAction(email)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true, completion: nil)
            
            //MARK: - 기존 회원 로그인
            
        case existUserLoginButton:
            let existingUserLoginVC = self.storyboard?.instantiateViewController(identifier: "ExistingUserLoginViewController") as! ExistingUserLoginViewController
            existingUserLoginVC.modalTransitionStyle = .crossDissolve
            existingUserLoginVC.modalPresentationStyle = .overFullScreen
            existingUserLoginVC.backgroundImage = background.image
            self.present(existingUserLoginVC, animated: true)
            
            //MARK: - Apple로 로그인
            
        case appleUserLoginButton:
            break
            
            //MARK: - 회원가입 없이 둘러보기
            
        case noSignUpButton:
            guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
            self.view.window?.rootViewController = mainVC
        default:
            break
        }
    }
}
