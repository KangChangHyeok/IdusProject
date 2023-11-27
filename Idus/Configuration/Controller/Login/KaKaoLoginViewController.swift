//
//  KakaoLoginPopUpViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/26.
//

import UIKit

import Firebase
import KakaoSDKUser

final class KaKaoLoginViewController: UIViewController {
    
    var userCollection = Firestore.firestore().collection("User")
    
    //MARK: - Initializer
    
    init?(nscoder: NSCoder) {
        super.init(coder: nscoder)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBAction
    
    @IBAction func kakaoTalkLoginButtonDidTap(_ sender: UIButton) {
        
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
//                    _ = oauthToken
                    UserApi.shared.me { user, error in
                        dump(user)
                        let document: [String: Any] = [
                            "loginType": "kakao",
                            "nickName": user?.kakaoAccount?.profile?.nickname,
                            "email": user?.kakaoAccount?.email,
                            "profileImage": user?.kakaoAccount?.profile?.profileImageUrl?.description
                        ]
                        self.userCollection.document("강창혁").setData(document)
                        
                        self.userCollection.getDocuments { querySnapshot, error in
                            querySnapshot?.documents.forEach({ snapshot in
                                if snapshot.documentID == "강창혁" {
                                    print("유저 존재함")
                                } else {
                                    print("유저 존재안함")
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    @IBAction func kakaoAccountLoginButtonDidTap(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                }
            }
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func buttonSet() {
        
    }
}
