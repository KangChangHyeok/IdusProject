// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let realTimeAndNewProductData = try? newJSONDecoder().decode(RealTimeAndNewProductData.self, from: jsonData)

import Foundation

// MARK: - RealTimeAndNewProductData
struct RealTimeAndNewProductData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [RealTimeAndNewResult]
}

// MARK: - Result
struct RealTimeAndNewResult: Codable {
    let productIdx, productCategoryIdx: Int
    let productTitleImage: String
    let productTitle: String
    let reviewStarRating, count: Int
    let starRating: RealTimeAndNewStarRating
    let reviewContent: String?
    let productDibs: ProductDibs
}

enum ProductDibs: String, Codable {
    case n = "N"
}

enum RealTimeAndNewStarRating: Codable {
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
