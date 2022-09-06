//
//  ExistingMemberViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/29.
//

import UIKit
import Alamofire

class ExistingUserLoginViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var naverUserButton: UIButton! {
        didSet {
            naverUserButton.layer.borderWidth = 1
            naverUserButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            naverUserButton.layer.cornerRadius = naverUserButton.frame.height / 2
        }
    }
    @IBOutlet weak var facebookUserButton: UIButton! {
        didSet {
            facebookUserButton.layer.borderWidth = 1
            facebookUserButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            facebookUserButton.layer.cornerRadius = naverUserButton.frame.height / 2
        }
    }
    @IBOutlet weak var kakaotalkUserButton: UIButton! {
        didSet {
            kakaotalkUserButton.layer.borderWidth = 1
            kakaotalkUserButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            kakaotalkUserButton.layer.cornerRadius = naverUserButton.frame.height / 2
        }
    }
    @IBOutlet weak var twiterUserButton: UIButton! {
        didSet {
            twiterUserButton.layer.borderWidth = 1
            twiterUserButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            twiterUserButton.layer.cornerRadius = naverUserButton.frame.height / 2
        }
        
    }
    @IBOutlet weak var appleUserButton: UIButton! {
        didSet {
            appleUserLoginButton.layer.borderWidth = 1
            appleUserLoginButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            appleUserLoginButton.layer.cornerRadius = naverUserButton.frame.height / 2
        }
    }
    @IBOutlet weak var dotLine: UIView! {
        didSet {
            dotLine.createDottedLine(width: 3, color: CGColor(red: 255, green: 255, blue: 255, alpha: 1))
        }
    }
    @IBOutlet weak var appleUserLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.borderWidth = 1
            loginButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            loginButton.layer.cornerRadius = naverUserButton.frame.height / 2
        }
    }
    @IBOutlet weak var background: UIImageView! {
        didSet {
            background.image = backgroundImage
        }
    }
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.setPlaceholder(color: .white)
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.setPlaceholder(color: .white)
        }
    }
    
    var backgroundImage: UIImage?
    let dataManager = DataManager()
    
    //MARK: - override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValue()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - setupValue
    
    func setupValue() {
        
    }
    
    //MARK: - IBAction
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
            
        case naverUserButton:
            break
        case facebookUserButton:
            break
        case kakaotalkUserButton:
            break
        case twiterUserButton:
            break
        case appleUserLoginButton:
            break
        case loginButton:
            let loginUserInformation = LoginInformation(userEmail: emailTextField.text, userPw: passwordTextField.text)
            dataManager.postLoginUserInformation(sender: loginUserInformation) { response in
                
                if response.isSuccess == true {
                    if let jwt = response.result?.jwt, let userIdx = response.result?.userIdx {
                        UserDefaults.standard.set(jwt, forKey: "jwt")
                        UserDefaults.standard.set(userIdx, forKey: "UserIdx")
                        self.dismiss(animated: true) {
                            guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController = mainVC
                        }
                        print("로그인이 완료되었습니다.")
                    }
                } else {
                    //isSuccess = false
                    switch response.code {
                        
                    case 2016:
                        let alert = UIAlertController(title: "이메일 형식을 확인해주세요.", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(alert, animated: true)
                        
                    case 4000:
                        let alert = UIAlertController(title: "데이터베이스 연결에 실패하였습니다.", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(alert, animated: true)
                        
                    case 4012:
                        let alert = UIAlertController(title: "비밀번호 복호화에 실패하였습니다.", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(alert, animated: true)
                        
                    case 4016:
                        let alert = UIAlertController(title: "이미 로그인된 아이디입니다.", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(alert, animated: true)
                        
                    case 4020:
                        let alert = UIAlertController(title: "회원탈퇴한 아이디입니다.", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(alert, animated: true)
                        
                    default:
                        break
                    }
                }
            }
            
        case cancelButton:
            self.dismiss(animated: true)
        default:
            break
        }
    }
}

extension ExistingUserLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
