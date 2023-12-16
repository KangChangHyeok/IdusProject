//
//  AppDelegate.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/25.
//

import CoreData
import UIKit

import Firebase
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // 앱 실행시 맨 처음 시작
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        KakaoSDK.initSDK(appKey: "50713411e03dd3c2529d17ef2e42815b")
        FirebaseApp.configure()
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
}

