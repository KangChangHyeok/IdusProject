//
//  BaseViewController.swift
//  Idus
//
//  Created by 강창혁 on 12/4/23.
//

import UIKit

/// 반복되는 코드 작성을 줄이기 위한 BaseViewController
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaults()
        configureUI()
    }
    
    /// 기본 초기값 설정 함수
    func configureDefaults() {
        
    }
    
    ///기본 UI 관련 레이아웃 설정 함수
    func configureUI() {
        
    }
}
