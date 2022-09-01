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
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var dotLine: UIView!
    @IBOutlet weak var kakaoSignUpButton: UIButton!
    @IBOutlet weak var otherSignUpButton: UIButton!
    @IBOutlet weak var existUserLoginButton: UIButton!
    @IBOutlet weak var appleUserLoginButton: UIButton!
    @IBOutlet weak var noSignUpButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    let backgroundImages = [UIImage(named: "1.jpg"), UIImage(named: "2.jpg"), UIImage(named: "3.jpg"), UIImage(named: "4.jpg")]
    
    //MARK: - override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValue()
    }
    //MARK: -배경화면 이미지 변경 애니메이션
    override func viewDidAppear(_ animated: Bool) {
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { timer in
            UIView.transition(with: self.background, duration: 3, options: .transitionCrossDissolve, animations: {
                self.background.image = self.backgroundImages.randomElement() as? UIImage
            }, completion: nil)
        })
    }
    func setupValue() {
        self.imageView.backgroundColor = .LoginViewImageBackgroundColor
        self.imageView.layer.cornerRadius = 10
        self.dotLine.createDottedLine(width: 3.0, color: UIColor.white.cgColor)
        
        self.kakaoSignUpButton.backgroundColor = .kakaoYellowColor
        self.kakaoSignUpButton.layer.cornerRadius = kakaoSignUpButton.frame.height / 2
        self.kakaoSignUpButton.tintColor = .kakaoFontColor
        
        self.existUserLoginButton.layer.borderWidth = 2
        self.existUserLoginButton.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.existUserLoginButton.layer.cornerRadius = existUserLoginButton.frame.height / 2
        self.appleUserLoginButton.layer.cornerRadius = appleUserLoginButton.frame.height / 2
    }
    
    //MARK: -카카오로 3초만에 시작하기 버튼을 눌렀을때
    @IBAction func kakaoSignUpButtonTapped(_ sender: UIButton) {
        let kakaoSignUpVC = self.storyboard?.instantiateViewController(withIdentifier: "KakaoSignUpViewController") as! KakaoSignUpViewController
        kakaoSignUpVC.modalTransitionStyle = .crossDissolve
        kakaoSignUpVC.modalPresentationStyle = .overFullScreen
        self.present(kakaoSignUpVC, animated: true, completion: nil)
        
    }
    //MARK: -다른 방법으로 가입하기 버튼을 눌렀을때
    @IBAction func otherSignUpButtonTapped(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "다른 방법으로 가입하기", message: nil, preferredStyle: .actionSheet)
        
        let naver = UIAlertAction(title: "네이버", style: .default)
        let facebook = UIAlertAction(title: "페이스북", style: .default)
        let twiter = UIAlertAction(title: "트위터", style: .default)
        let email = UIAlertAction(title: "이메일", style: .default) { _ in
            let EmailSignUpVC = self.storyboard?.instantiateViewController(identifier: "EmailSignUpViewController") as! EmailSignUpViewController
            EmailSignUpVC.modalTransitionStyle = .crossDissolve
            EmailSignUpVC.modalPresentationStyle = .overFullScreen
            self.present(EmailSignUpVC, animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        actionSheet.addAction(naver)
        actionSheet.addAction(facebook)
        actionSheet.addAction(twiter)
        actionSheet.addAction(email)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
        
    }
    //MARK: - 기존 회원 로그인 버튼 눌렀을때
    @IBAction func existUserLoginButtonTapped(_ sender: Any) {
        let ExistingMemberViewController = self.storyboard?.instantiateViewController(identifier: "ExistingMemberViewController") as! ExistingMemberViewController
        ExistingMemberViewController.modalTransitionStyle = .crossDissolve
        ExistingMemberViewController.modalPresentationStyle = .overFullScreen
        self.present(ExistingMemberViewController, animated: true, completion: nil)
        
    }
    //MARK: - 회원가입 없이 둘러보기 버튼 눌렀을때
    @IBAction func noSignUpButtonTapped(_ sender: UIButton) {
        guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
    }
}
