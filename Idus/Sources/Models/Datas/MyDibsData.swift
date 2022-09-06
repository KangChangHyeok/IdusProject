// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myDibsData = try? newJSONDecoder().decode(MyDibsData.self, from: jsonData)

import Foundation

// MARK: - MyDibsData
struct MyDibsData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [MyDibsResult]
}

// MARK: - Result
struct MyDibsResult: Codable {
    let productIdx, productCategoryIdx: Int
    let productTitleImage: String
    let productTitle: String
    let reviewStarRating, count: Int
    let starRating: MyDibsStarRating
    let reviewContent: String?
    let productDibs: String
}

enum MyDibsStarRating: Codable {
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
