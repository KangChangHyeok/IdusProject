// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let signUpResult = try? newJSONDecoder().decode(SignUpResult.self, from: jsonData)

import Foundation

// MARK: - SignUpResult
struct ResponseResult: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: Result?
}

// MARK: - Result
struct Result: Codable {
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
