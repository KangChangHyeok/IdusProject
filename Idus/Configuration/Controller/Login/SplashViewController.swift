//
//  SplashViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/26.
//

import UIKit
import AVFoundation

class SplashViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var splashMainV: UIView!
    @IBOutlet weak var dottedV: UIView!
    @IBOutlet weak var kakaoButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var existButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var noMemeberButton: UIButton!
    @IBOutlet weak var transitionV: UIImageView!
    
    let images = [UIImage(named: "1.jpg"), UIImage(named: "2.jpg"), UIImage(named: "3.jpg"), UIImage(named: "4.jpg")]
    
    //MARK: - override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        splashMainVSet()
        buttonSet()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { timer in
            UIView.transition(with: self.transitionV, duration: 3, options: .transitionCrossDissolve, animations: {
                self.transitionV.image = self.images.randomElement() as! UIImage
            }, completion: nil)
        })
    }
    
    //MARK: - customFunction
    func splashMainVSet() {
        splashMainV.backgroundColor = .splashPVCColor
        splashMainV.layer.cornerRadius = 10
        self.dottedV.createDottedLine(width: 3.0, color: UIColor.white.cgColor)
    }
    
    func buttonSet() {
        self.kakaoButton.backgroundColor = .kakaoyellow
        self.kakaoButton.layer.cornerRadius = kakaoButton.frame.height / 2
        self.kakaoButton.tintColor = .kakaofont
        
        self.existButton.layer.borderWidth = 2
        self.existButton.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.existButton.layer.cornerRadius = existButton.frame.height / 2
        self.appleButton.layer.cornerRadius = appleButton.frame.height / 2
    }
    
    //MARK: - IBActionFunction
    @IBAction func kakaoLogin(_ sender: UIButton) {
        let kakaoLoginPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "KakaoLoginPopUpViewController") as! KakaoLoginPopUpViewController
        kakaoLoginPopupVC.modalTransitionStyle = .crossDissolve
        kakaoLoginPopupVC.modalPresentationStyle = .overFullScreen
        self.present(kakaoLoginPopupVC, animated: true, completion: nil)
        
    }
    
    @IBAction func otherLogin(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "다른 방법으로 가입하기", message: nil, preferredStyle: .actionSheet)
        
        let naverAction = UIAlertAction(title: "네이버", style: .default) { _ in
            print("네이버")
        }
        let facebookAction = UIAlertAction(title: "페이스북", style: .default) { _ in
            print("페이스북")
        }
        let twiterAction = UIAlertAction(title: "트위터", style: .default) { _ in
            print("트위터")
        }
        let emailAction = UIAlertAction(title: "이메일", style: .default) { _ in
            let EmailSignUpViewController = self.storyboard?.instantiateViewController(identifier: "EmailSignUpViewController") as! EmailSignUpViewController
            EmailSignUpViewController.modalTransitionStyle = .crossDissolve
            EmailSignUpViewController.modalPresentationStyle = .overFullScreen
            self.present(EmailSignUpViewController, animated: true) {
    
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        actionSheet.addAction(naverAction)
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(twiterAction)
        actionSheet.addAction(emailAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func existUserLogin(_ sender: Any) {
        let ExistingMemberViewController = self.storyboard?.instantiateViewController(identifier: "ExistingMemberViewController") as! ExistingMemberViewController
        ExistingMemberViewController.modalTransitionStyle = .crossDissolve
        ExistingMemberViewController.modalPresentationStyle = .overFullScreen
        self.present(ExistingMemberViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func notUserLogin(_ sender: UIButton) {
        guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
    }
}
