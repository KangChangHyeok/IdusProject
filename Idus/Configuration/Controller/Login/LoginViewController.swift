//
//  SplashViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/26.
//

import AVFoundation
import UIKit

final class LoginViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var dottedView: UIView! {
        didSet {
            dottedView.dottedLine(width: 1.0, color: UIColor.white.cgColor)
        }
    }
    @IBOutlet weak var kakaoButton: UIButton! {
        didSet {
            kakaoButton.layer.cornerRadius = kakaoButton.frame.height / 2
        }
    }
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var existButton: UIButton! {
        didSet {
            existButton.layer.borderWidth = 1
            existButton.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
            existButton.layer.cornerRadius = existButton.frame.height / 2
        }
    }
    @IBOutlet weak var appleButton: UIButton! {
        didSet {
            appleButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var noMemeberButton: UIButton!
    @IBOutlet weak var transitionV: UIImageView!
    
    private let images: [UIImage] = [
        .init(named: "1")!, .init(named: "2")!, .init(named: "3")!, .init(named: "4")!
    ]
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { timer in
            UIView.transition(
                with: self.transitionV,
                duration: 3,
                options: .transitionCrossDissolve,
                animations: {
                self.transitionV.image = self.images.randomElement()
            }, completion: nil
            )
        })
    }
    
    //MARK: - IBAction
    
    @IBAction func kakaoLoginButtonDidTap(_ sender: UIButton) {
        
        guard let kakaoLoginViewController = storyboard?.instantiateViewController(
            identifier: "KaKaoLogin", creator: { nscoder in
            let viewController = KaKaoLoginViewController(nscoder: nscoder)
            return viewController
        })
        else { return }
        
        self.present(kakaoLoginViewController, animated: true, completion: nil)
    }
    
    @IBAction func anotherLoginButtonDidTap(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(
            title: "다른 방법으로 가입하기", message: nil, preferredStyle: .actionSheet
        )
        
        let naverAction = UIAlertAction(title: "네이버", style: .default) { _ in
            print("네이버")
        }
        let facebookAction = UIAlertAction(title: "페이스북", style: .default) { _ in
            print("페이스북")
        }
        let twiterAction = UIAlertAction(title: "트위터", style: .default) { _ in
            print("트위터")
        }
        let emailAction = UIAlertAction(title: "이메일", style: .default) { [weak self] _ in
            
            guard let emailSignUpViewController = self?.storyboard?.instantiateViewController(
                identifier: "EmailSignUp",
                creator: { nsCoder in
                let emailSignUpViewController = EmailSignUpViewController(nsCoder: nsCoder)
                return emailSignUpViewController
                }) as? EmailSignUpViewController
            else { return }
            
            self?.present(emailSignUpViewController, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        actionSheet.addAction(naverAction)
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(twiterAction)
        actionSheet.addAction(emailAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func existUserLoginButtonDidTap(_ sender: Any) {
        
        guard let existingMemberViewController = self.storyboard?.instantiateViewController(
            identifier: "UserLogin",
            creator: { nsCoder in
            let viewController = UserLoginViewController(nscoder: nsCoder)
            return viewController
        }) as? UserLoginViewController
        else { return }
        
        present(existingMemberViewController, animated: true)
    }
    
    @IBAction func guestLoginButtonDidTap(_ sender: UIButton) {
        
        guard let mainViewController = self.storyboard?.instantiateViewController(
            withIdentifier: "Main"
        ) as? TabBarController
        else { return }
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(mainViewController, animated: false)
    }
}
