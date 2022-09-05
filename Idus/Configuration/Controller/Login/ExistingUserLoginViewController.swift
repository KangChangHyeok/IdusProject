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
    @IBOutlet weak var naverUserButton: UIButton!
    @IBOutlet weak var facebookUserButton: UIButton!
    @IBOutlet weak var kakaotalkUserButton: UIButton!
    @IBOutlet weak var twiterUserButton: UIButton!
    @IBOutlet weak var appleUserButton: UIButton!
    @IBOutlet weak var dotLine: UIView!
    @IBOutlet weak var appleUserLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    //MARK: - IBAction
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    //MARK: - setupValue
    func setupValue() {
        background.image = backgroundImage
        self.naverUserButton.layer.borderWidth = 1
        self.naverUserButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.naverUserButton.layer.cornerRadius = naverUserButton.frame.height / 2
        
        self.facebookUserButton.layer.borderWidth = 1
        self.facebookUserButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.facebookUserButton.layer.cornerRadius = naverUserButton.frame.height / 2
        
        self.kakaotalkUserButton.layer.borderWidth = 1
        self.kakaotalkUserButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.kakaotalkUserButton.layer.cornerRadius = naverUserButton.frame.height / 2
        
        self.twiterUserButton.layer.borderWidth = 1
        self.twiterUserButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.twiterUserButton.layer.cornerRadius = naverUserButton.frame.height / 2
        
        self.appleUserLoginButton.layer.borderWidth = 1
        self.appleUserLoginButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.appleUserLoginButton.layer.cornerRadius = naverUserButton.frame.height / 2
        
        self.dotLine.createDottedLine(width: 3, color: CGColor(red: 255, green: 255, blue: 255, alpha: 1))
        
        self.loginButton.layer.borderWidth = 1
        self.loginButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.loginButton.layer.cornerRadius = naverUserButton.frame.height / 2
        
        self.emailTextField.setPlaceholder(color: .white)
        self.passwordTextField.setPlaceholder(color: .white)
        
    }
    
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
