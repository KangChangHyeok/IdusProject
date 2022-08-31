//
//  ExistingMemberViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/29.
//

import UIKit
import Alamofire
class ExistingMemberViewController: UIViewController {
    
    @IBOutlet weak var naverButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var kakaoTalkButton: UIButton!
    @IBOutlet weak var twiterButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var dotLineV: UIView!
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    
    var viewBlurEffect: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISet()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    func UISet() {
        self.naverButton.layer.borderWidth = 1
        self.naverButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.naverButton.layer.cornerRadius = naverButton.frame.height / 2
        
        self.facebookButton.layer.borderWidth = 1
        self.facebookButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.facebookButton.layer.cornerRadius = naverButton.frame.height / 2
        
        self.kakaoTalkButton.layer.borderWidth = 1
        self.kakaoTalkButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.kakaoTalkButton.layer.cornerRadius = naverButton.frame.height / 2
        
        self.twiterButton.layer.borderWidth = 1
        self.twiterButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.twiterButton.layer.cornerRadius = naverButton.frame.height / 2
        
        self.appleLoginButton.layer.borderWidth = 1
        self.appleLoginButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.appleLoginButton.layer.cornerRadius = naverButton.frame.height / 2
        
        self.dotLineV.createDottedLine(width: 3, color: CGColor(red: 255, green: 255, blue: 255, alpha: 1))
        
        self.loginButton.layer.borderWidth = 1
        self.loginButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.loginButton.layer.cornerRadius = naverButton.frame.height / 2
        
        self.emailTF.setPlaceholder(color: .white)
        self.pwTF.setPlaceholder(color: .white)
        
        //블러 처리
        
        viewBlurEffect = UIVisualEffectView()
        viewBlurEffect.effect = UIBlurEffect(style: .systemThinMaterialDark)
        
        
        self.backgroundImage.addSubview(viewBlurEffect)
        viewBlurEffect.frame = self.backgroundImage.bounds
    }
    
    func loginResultNetWork(completion: @escaping (ResponseResult) -> Void) {
        let parameters: Parameters = [
            "userEmail": "\(self.emailTF.text!)",
            "userPw": "\(self.pwTF.text!)"
        ]
        AF.request(
            Keys.baseURL + "/users/email-login",
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
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loginResultNetWork { result in
            if result.isSuccess == true {
                
                UserInfo.shared.useridx = result.result?.userIdx
                UserInfo.shared.jwt = result.result?.jwt
                
                self.dismiss(animated: true) {
                    guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
                }
            }
            else {
                print("로그인 안됌")
            }
        }
    }
}


extension ExistingMemberViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTF.resignFirstResponder()
        pwTF.resignFirstResponder()
        return true
    }
}
