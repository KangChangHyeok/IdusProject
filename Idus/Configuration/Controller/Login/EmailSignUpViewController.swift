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
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var checkBoxView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var recommendTextField: UITextField!
    
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
    override func viewDidAppear(_ animated: Bool) {
        print(self.presentingViewController)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: - setUpValue
    func setUpValue() {
        self.background.image = backgroundImage
        self.emailTextField.setPlaceholder(color: .white)
        self.emailTextField.delegate = self
        self.nameTextField.setPlaceholder(color: .white)
        self.nameTextField.delegate = self
        self.passwordTextField.setPlaceholder(color: .white)
        self.passwordTextField.delegate = self
        self.passwordCheckTextField.setPlaceholder(color: .white)
        self.passwordCheckTextField.delegate = self
        self.phoneNumberTextField.setPlaceholder(color: .white)
        self.phoneNumberTextField.delegate = self
        self.recommendTextField.setPlaceholder(color: .white)
        self.recommendTextField.delegate = self
        
        self.checkBoxView.layer.cornerRadius = 4
        self.checkBoxView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.checkBoxView.layer.borderWidth = 1
        
        self.signUpButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.signUpButton.layer.cornerRadius = self.signUpButton.frame.height / 2
        self.signUpButton.layer.borderWidth = 1
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
//            let signUpUserInformation = SignUpUserInformation(userName: nameTextField.text, userEmail: emailTextField.text, userPw: passwordCheckTextField.text, userPhoneNumber: phoneNumberTextField.text)
//            dataManager.postSignUpUserInformation(sender: signUpUserInformation) { response in
//                if response.isSuccess == true {
//                    print("회원가입이 완료되었습니다.")
//                    //회원가입 성공시 UserDefalut에 jwt 값과 userIdx 저장
//                    if let jwt = response.result?.jwt, let userIdx = response.result?.userIdx {
//                        UserDefaults.standard.set(jwt, forKey: "jwt")
//                        UserDefaults.standard.set(userIdx, forKey: "UserIdx")
//                    }
//                } else {
//                    //result code에 따른 분기처리
//                    switch response.code {
//                    case 2015:
//                        let alert = UIAlertController(title: "이메일을 입력해주세요", message: nil, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .default))
//                        self.present(alert, animated: true)
//                    case 2016:
//                        let alert = UIAlertController(title: "이메일 형식을 확인해주세요", message: nil, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .default))
//                        self.present(alert, animated: true)
//                    case 2018:
//                        let alert = UIAlertController(title: "이름의 길이는 20자 이하로 정해주세요.", message: nil, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .default))
//                        self.present(alert, animated: true)
//                    case 2019:
//                        let alert = UIAlertController(title: "비밀번호는 8자 이상으로 정해주세요.", message: nil, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .default))
//                        self.present(alert, animated: true)
//                    case 2020:
//                        let alert = UIAlertController(title: "비밀번호 형식을 확인해주세요.", message: nil, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .default))
//                        self.present(alert, animated: true)
//                    case 2021:
//                        let alert = UIAlertController(title: "전화번호 형식을 확인해주세요.", message: nil, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .default))
//                        self.present(alert, animated: true)
//                    case 3013:
//                        let alert = UIAlertController(title: "중복된 이메일입니다.", message: nil, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .default))
//                        self.present(alert, animated: true)
//                    case 3015:
//                        let alert = UIAlertController(title: "중복된 전화번호입니다.", message: nil, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .default))
//                        self.present(alert, animated: true)
//                    default:
//                        break
//                    }
//                }
//            }
            self.dismiss(animated: true) {
                guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController = mainVC
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
