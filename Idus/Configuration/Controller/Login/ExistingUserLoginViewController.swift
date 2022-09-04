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
    @IBOutlet weak var pwTextField: UITextField!
    
    var backgroundImage: UIImage?
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
        self.pwTextField.setPlaceholder(color: .white)
        
    }
    
//    func loginResultNetWork(completion: @escaping (ResponseResult) -> Void) {
//        let parameters: Parameters = [
//            "userEmail": "\(self.emailTF.text!)",
//            "userPw": "\(self.pwTF.text!)"
//        ]
//        AF.request(
//            baseURL + "/users/email-login",
//            method: .post,
//            parameters: parameters, encoding: JSONEncoding.default,headers: headers)
//        .responseDecodable(of: ResponseResult.self) { response in
//            switch response.result {
//            case .success(let result):
//                print(result)
//                completion(result)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
//        loginResultNetWork { result in
//            if result.isSuccess == true {
//
//                UserInfo.shared.useridx = result.result?.userIdx
//                UserInfo.shared.jwt = result.result?.jwt
//
//                self.dismiss(animated: true) {
//                    guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
//                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
//                }
//            }
//            else {
//                print("로그인 안됌")
//            }
//        }
    }
}


extension ExistingUserLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
        return true
    }
}
