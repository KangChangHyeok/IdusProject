//
//  EmailSignUpViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/27.
//

import UIKit
import Alamofire

class EmailSignUpViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var background: UIImageView! {
        didSet {
            background.image = backgroundImage
        }
    }
    @IBOutlet weak var checkBoxView: UIView! {
        didSet {
            checkBoxView.layer.cornerRadius = 4
            checkBoxView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            checkBoxView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            signUpButton.layer.cornerRadius = self.signUpButton.frame.height / 2
            signUpButton.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.setPlaceholder(color: .white)
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.setPlaceholder(color: .white)
            nameTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.setPlaceholder(color: .white)
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordCheckTextField: UITextField! {
        didSet {
        passwordCheckTextField.setPlaceholder(color: .white)
        passwordCheckTextField.delegate = self
        }
    }
    @IBOutlet weak var phoneNumberTextField: UITextField! {
        didSet {
            phoneNumberTextField.setPlaceholder(color: .white)
            phoneNumberTextField.delegate = self
        }
    }
    @IBOutlet weak var recommendTextField: UITextField! {
        didSet {
            recommendTextField.setPlaceholder(color: .white)
            recommendTextField.delegate = self
        }
    }
    
    @IBOutlet weak var allArgeeButton: UIButton!
    @IBOutlet weak var checkButton1: UIButton!
    @IBOutlet weak var checkButton2: UIButton!
    @IBOutlet weak var checkButton3: UIButton!
    @IBOutlet weak var checkButton4: UIButton!
    
    var backgroundImage: UIImage?
    let dataManager = DataManager()
    
    //MARK: - override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - setUpValue
    
    func setUpValue() {
        
    }
    
    //MARK: - IBAction
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case cancelButton:
            self.dismiss(animated: true)
            
        case allArgeeButton:
            if allArgeeButton.isSelected {
                allArgeeButton.isSelected = false
                checkButton1.isSelected = false
                checkButton2.isSelected = false
                checkButton3.isSelected = false
                checkButton4.isSelected = false
            } else {
                allArgeeButton.isSelected = true
                checkButton1.isSelected = true
                checkButton2.isSelected = true
                checkButton3.isSelected = true
                checkButton4.isSelected = true
            }
            
        case checkButton1:
            checkButton1.isSelected.toggle()
        case checkButton2:
            checkButton2.isSelected.toggle()
        case checkButton3:
            checkButton3.isSelected.toggle()
        case checkButton4:
            checkButton4.isSelected.toggle()
            
        case signUpButton:
            let signUpUserInformation = SignUpUserInformation(userName: nameTextField.text, userEmail: emailTextField.text, userPw: passwordCheckTextField.text, userPhoneNumber: phoneNumberTextField.text)
            dataManager.postSignUpUserInformation(sender: signUpUserInformation) { response in
                if response.isSuccess == true {
                    print("회원가입이 완료되었습니다.")
                    //회원가입 성공시 UserDefalut에 jwt 값과 userIdx 저장
                    if let jwt = response.result?.jwt, let userIdx = response.result?.userIdx {
                        UserDefaults.standard.set(jwt, forKey: "jwt")
                        UserDefaults.standard.set(userIdx, forKey: "UserIdx")
                        self.dismiss(animated: true) {
                            guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController = mainVC
                        }
                    }
                } else {
                    //result code에 따른 분기처리
                    switch response.code {
                    case 2015:
                        let alert = UIAlertController().createCheckAlertController(title: "이메일 입력을 확인해 주세요.")
                        self.present(alert, animated: true)
                    case 2016:
                        let alert = UIAlertController().createCheckAlertController(title: "이메일 형식을 확인해 주세요.")
                        self.present(alert, animated: true)
                    case 2018:
                        let alert = UIAlertController().createCheckAlertController(title: "이름의 길이는 20자 이하로 정해주세요.")
                        self.present(alert, animated: true)
                    case 2019:
                        let alert = UIAlertController().createCheckAlertController(title: "비밀번호는 8자 이상으로 정해주세요.")
                        self.present(alert, animated: true)
                    case 2020:
                        let alert = UIAlertController().createCheckAlertController(title: "비밀번호 형식을 확인해주세요.")
                        self.present(alert, animated: true)
                    case 2021:
                        let alert = UIAlertController().createCheckAlertController(title: "전화번호 형식을 확인해주세요.")
                        self.present(alert, animated: true)
                    case 3013:
                        let alert = UIAlertController().createCheckAlertController(title: "중복된 이메일입니다.")
                        self.present(alert, animated: true)
                    case 3015:
                        let alert = UIAlertController().createCheckAlertController(title: "중복된 전화번호입니다.")
                        self.present(alert, animated: true)
                    default:
                        break
                    }
                }
            }
        default:
            break
        }
    }
}
extension EmailSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            resignFirstResponder()
        case nameTextField:
            resignFirstResponder()
        case passwordTextField:
            resignFirstResponder()
        case passwordCheckTextField:
            resignFirstResponder()
        case recommendTextField:
            resignFirstResponder()
        default:
            break
        }
        return true
    }
}
