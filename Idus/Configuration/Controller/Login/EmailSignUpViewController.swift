//
//  EmailSignUpViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/27.
//

import Alamofire
import UIKit

final class EmailSignUpViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var checkBoxV: UIView!
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var pwCheckTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var recommendTF: UITextField!
    
    //checkbox button
    @IBOutlet weak var allArgeeButton: UIButton!
    @IBOutlet weak var checkButton1: UIButton!
    @IBOutlet weak var checkButton2: UIButton!
    @IBOutlet weak var checkButton3: UIButton!
    @IBOutlet weak var checkButton4: UIButton!
    
    var viewBlurEffect: UIVisualEffectView!
    
    init?(nsCoder: NSCoder) {
        super.init(coder: nsCoder)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurSet()
        checkBoxVSet()
        textFieldVSet()
        buttonSet()
        
        
    }
    
    //화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //뒷배경 블러처리
    func blurSet() {
        viewBlurEffect = UIVisualEffectView()
        viewBlurEffect.effect = UIBlurEffect(style: .systemThinMaterialDark)
        
        
        self.backgroundImage.addSubview(viewBlurEffect)
        viewBlurEffect.frame = self.backgroundImage.bounds
    }
    
    func textFieldVSet() {
        self.emailTF.setPlaceholder(color: .white)
        self.emailTF.delegate = self
        self.nameTF.setPlaceholder(color: .white)
        self.nameTF.delegate = self
        self.pwTF.setPlaceholder(color: .white)
        self.pwTF.delegate = self
        self.pwCheckTF.setPlaceholder(color: .white)
        self.pwCheckTF.delegate = self
        self.phoneTF.setPlaceholder(color: .white)
        self.phoneTF.delegate = self
        self.recommendTF.setPlaceholder(color: .white)
        self.recommendTF.delegate = self
    }
    //체크박스 항목 설정
    func checkBoxVSet() {
        self.checkBoxV.layer.cornerRadius = 4
        self.checkBoxV.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.checkBoxV.layer.borderWidth = 1
    }
    
    func buttonSet() {
        self.signUpButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.signUpButton.layer.cornerRadius = self.signUpButton.frame.height / 2
        self.signUpButton.layer.borderWidth = 1
    }
    
    func signUpResultNetWork(completion: @escaping (ResponseResult) -> Void) {
        let parameters: Parameters = [
            "userName": "\(self.nameTF.text!)",
            "userEmail": "\(self.emailTF.text!)",
            "userPw": "\(self.pwTF.text!)",
            "userPhoneNumber": "\(self.phoneTF.text!)"
        ]
        AF.request(
            Keys.baseURL + "/users",
            method: .post,
            parameters: parameters, encoding: JSONEncoding.default,headers: Keys.headers)
        .responseDecodable(of: ResponseResult.self) { response in
            switch response.result {
            case .success(let result):
                
                print(result)
                completion(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //체크박스 선택 관련
    @IBAction func allAreee(_ sender: UIButton) {
        sender.isSelected.toggle()
        checkButton1.isSelected.toggle()
        checkButton2.isSelected.toggle()
        checkButton3.isSelected.toggle()
        checkButton4.isSelected.toggle()
        print(checkButton1.isSelected)
    }
    @IBAction func check1(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    @IBAction func check2(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    @IBAction func check3(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    @IBAction func check4(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        signUpResultNetWork { signUpResult in
            if signUpResult.isSuccess! == true {
                print("회원가입이 완료되었습니다.")
                self.dismiss(animated: true) {
                    guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
                }
            }
            else {
            }
        }
    }
}




extension EmailSignUpViewController: UITextFieldDelegate {
    
    //return 버튼 누르게 되면 키보드 내려주기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTF.resignFirstResponder()
        nameTF.resignFirstResponder()
        pwTF.resignFirstResponder()
        pwCheckTF.resignFirstResponder()
        recommendTF.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //전화번호 인증 구현
//        if textField == phoneTF {
//            let PhoneNumberCheckViewController = self.storyboard?.instantiateViewController(identifier: "PhoneNumberCheckViewController") as! PhoneNumberCheckViewController
//            PhoneNumberCheckViewController.modalTransitionStyle = .crossDissolve
//            PhoneNumberCheckViewController.modalPresentationStyle = .overFullScreen
//            self.present(PhoneNumberCheckViewController, animated: true, completion: nil)
//        }
    }
}
