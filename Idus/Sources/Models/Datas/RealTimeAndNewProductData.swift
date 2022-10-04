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
    let reviewContent: String?
    let productDibs: ProductDibs
}

enum ProductDibs: String, Codable {
    case n = "N"
}
