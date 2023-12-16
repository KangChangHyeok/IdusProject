//
//  BaseView.swift
//  Idus
//
//  Created by 강창혁 on 12/16/23.
//

import UIKit

/// 반복되는 코드 작성을 줄이기 위한 BaseView
class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDefaults()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 기본 초기값 설정 함수
    func configureDefaults() {
        
    }
    
    ///기본 UI 관련 레이아웃 설정 함수
    func configureUI() {
        
    }
}
