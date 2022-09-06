// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let signUpResult = try? newJSONDecoder().decode(SignUpResult.self, from: jsonData)

import Foundation

// MARK: - SignUpUserInformationResponse(API 1.)
struct PostSignUpUserInformationResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: PostSignUpUserInformationResult?
}
struct PostSignUpUserInformationResult: Codable {
    let userIdx: Int
    let jwt: String
}
//MARK: - LoginUserInformationResponse(API 5.)
struct PostLoginUserInformationResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: PostLoginUserInformationResult?
}

struct PostLoginUserInformationResult: Codable {
    let userIdx: Int
    let jwt: String
}
// MARK: - SignUpResult
struct LogOutResult: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message, result: String?
}

struct CardResigsterResult: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: String?
}
