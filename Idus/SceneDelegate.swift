//
//  SceneDelegate.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/25.
//

import UIKit

import KakaoSDKUser
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var isLogged: Bool = false
    var window: UIWindow?
    
    func changeRootViewController (_ vc: UIViewController, animated: Bool) {
        guard let window = self.window else { return }
        window.rootViewController = vc // 전환
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            if let url = URLContexts.first?.url {
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}

