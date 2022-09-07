//
//  PostLoginUserInformationResponse.swift
//  Idus
//
//  Created by 강창혁 on 2022/09/07.
//

import Foundation

//MARK: - LoginUserInformationResponse(API 5.)

struct LoginUserData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: LoginUserDataResult?
}

struct LoginUserDataResult: Codable {
    let userIdx: Int
    let jwt: String
}
