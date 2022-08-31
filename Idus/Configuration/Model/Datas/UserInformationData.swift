// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userInformationData = try? newJSONDecoder().decode(UserInformationData.self, from: jsonData)

import Foundation

// MARK: - UserInformationData
struct UserInformationData: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: UserInformationResult?
}

// MARK: - Result
struct UserInformationResult: Codable {
    let userIdx: Int?
    let userImageURL: String?
    let userName, userEmail: String?
    let userGender: String?
    let userPhoneNumber: String?
    let getUserShippingAddress: [GetUserShippingAddress]?

    enum CodingKeys: String, CodingKey {
        case userIdx
        case userImageURL
        case userName, userEmail, userGender, userPhoneNumber, getUserShippingAddress
    }
}

// MARK: - GetUserShippingAddress
struct GetUserShippingAddress: Codable {
    let userIdx: Int?
    let receiveUserName, receiveUserPhoneNumber, receiveUserAddress: String?
}

