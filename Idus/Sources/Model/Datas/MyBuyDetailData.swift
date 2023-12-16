// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let detailData = try? newJSONDecoder().decode(DetailData.self, from: jsonData)

import Foundation

// MARK: - DetailData
struct MyBuyDetailData: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [MyBuyResult]?
}

// MARK: - Result
struct MyBuyResult: Codable {
    let userIdx, productIdx, sellerIdx: Int?
    let productTitleImageURL: String?
    let shippingDate, sellerNickname, optionContent: String?
    let productCount, totalMoney: Int?
    let cardNumber, cardBN: String?
    let receiveUserName, receiveUserPhoneNumber, receiveUserAddress: String?
    let paymentInfo, requestContent, completed: String?

    enum CodingKeys: String, CodingKey {
        case userIdx, productIdx, sellerIdx
        case productTitleImageURL
        case shippingDate, sellerNickname, optionContent, productCount, totalMoney, cardNumber, cardBN, receiveUserName, receiveUserPhoneNumber, receiveUserAddress, paymentInfo, requestContent, completed
    }
}

