// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let detailData = try? newJSONDecoder().decode(DetailData.self, from: jsonData)

import Foundation

// MARK: - DetailData
struct DetailData: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: DetailResult?
}

// MARK: - Result
struct DetailResult: Codable {
    let productImages: [ProductImage]
    let product: DetailProduct?
    let productKeyword: [ProductKeyword]?
    let productReview: [ProductReview]?
    let sellerInfo: SellerInfo?
}

// MARK: - Product
struct DetailProduct: Codable {
    let productIdx, sellerIdx, productCategoryIdx: Int?
    let productTitle: String?
    let productDiscountRate: Int?
    let productRealPrice, productDiscountPrice: String?
    let productSavePoint: Int?
    let productDeliveryFee, productDeliveryDate: String?
    let productRemainingNum: Int?
    let productInfo, productKind, productProductionInfo, productExpirationDate: String?
    let productPackagingInfo, productMaterialInfo, productNutrientInfo, productGMOInfo: String?
    let productSideEffectInfo, productIncomeInfo: String?
    let productInquiry: String?
    let productDeliveryComment, productRefundCondition: String?
    let productIndication, productComposition, productKeepMathod: String?
    let sellerEmail, representativeName, productDibs: String?
    let productDibsCount: Int?
}

// MARK: - ProductImage
struct ProductImage: Codable {
    let productImageUrl: String?
    let titleImage: String?
    
}

// MARK: - ProductKeyword
struct ProductKeyword: Codable {
    let keyword: String?
}

// MARK: - ProductReview
struct ProductReview: Codable {
    let reviewImage: String?
    let reviewContent: String?
    let reviewStarRating: Int?
    let optionContent: String?
}

// MARK: - SellerInfo
struct SellerInfo: Codable {
    let sellerNickname: String?
    let sellerFollowerCount, sellerSponsorCount: Int?
    let sellerContent: String?
    let dibsCount, reviewStarRating, count: Int?
    let starRating: DetailStarRating?
    let sellerIdx: Int?
}

enum DetailStarRating: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(StarRating.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StarRating"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
