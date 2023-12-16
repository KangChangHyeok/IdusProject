//
//  DataManager.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/03.
//

import UIKit
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    ///completion Handler 사용
    func fetchImages(count: Int, completion: @escaping (BannerImages?) -> Void) {
        guard var urlComponent = URLComponents(string: "https://picsum.photos/v2/list") else { return }
        
        let pageQuery = URLQueryItem(name: "page", value: "2")
        let limitQuery = URLQueryItem(name: "limit", value: "\(count)")
        urlComponent.queryItems = [pageQuery, limitQuery]
        
        guard let url = urlComponent.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
            }
            
            let response = response as? HTTPURLResponse
            
            guard response?.statusCode == 200 else {
                print(response?.statusCode) 
                return
            }
            
            let bannerImages = try? JSONDecoder().decode(BannerImages.self, from: data!)
            DispatchQueue.main.async {
                completion(bannerImages)
            }
        }.resume()
    }
    
    // async / await 사용. 코드가 훨씬 줄어들고 위 -> 아래 자연스러운 흐름이어서 더 잘읽히는듯.
    func fetchImages(count: Int) async throws -> BannerImages? {
        guard var urlComponent = URLComponents(string: "https://picsum.photos/v2/list") else { return nil}
        let pageQuery = URLQueryItem(name: "page", value: "3")
        let limitQuery = URLQueryItem(name: "limit", value: "\(count)")
        urlComponent.queryItems = [pageQuery, limitQuery]
        guard let url = urlComponent.url else { return nil}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let bannerImages = try JSONDecoder().decode(BannerImages.self, from: data)
            return bannerImages
        } catch {
            throw error
        }
    }
    
    func postLogOut(completion: @escaping (LogOutResult) -> Void) {
        AF.request(
            "\(Keys.baseURL)/users/logout/\(UserInfo.shared.useridx!)",
            method: .patch,
            encoding: JSONEncoding.default,
            headers: Keys.jwtHeaders)
        .responseDecodable(of: LogOutResult.self) { response in
            switch response.result {
            case .success(let response):
                completion(response)
                
            case .failure(let error):
                print("에러다!!! Error : \(error.localizedDescription)\n\(error)")
            }
        }
    }
    
    //MARK: - API Index 10(회원 조회 API)
    
    func getUserInformation(completion: @escaping (UserInformationData) -> Void) {
        
        AF.request("https://prod.idus-b.shop/users/\(UserInfo.shared.useridx!)",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: Keys.jwtHeaders
        ).responseDecodable(of: UserInformationData.self) { result in
            
            switch result.result {
            case .success(let success):
                completion(success)
            case.failure(let error):
                debugPrint(error)
            }
            
        }
    }
    
    //MARK: - API Index 11(투데이 작품 전체 조회)
    var todayProductData: TodayProductData?
    
    func getTodayProductData(completion: @escaping (TodayProductData) -> Void) {
        AF.request(Keys.baseURL + "/products/today",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: Keys.jwtHeaders
        ).responseDecodable(of: TodayProductData.self) { result in
            
            switch result.result {
            case .success(let success):
                self.todayProductData = success
                completion(self.todayProductData!)
            case.failure(let error):
                debugPrint(error)
            }
            
        }
    }
    //MARK: - API Index 12(작품 상세 조회)
    
    var detailData: DetailData?
    func getDetailData(completion: @escaping (DetailData) -> Void) {
        
        AF.request(Keys.baseURL + "/products/\(DetailViewController.productIdx!)",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: Keys.jwtHeaders
        ).responseDecodable(of: DetailData.self) { result in
            
            switch result.result {
            case .success(let success):
                self.detailData = success
                completion(self.detailData!)
            case.failure(let error):
                debugPrint(error)
            }
            
        }
    }
    
    
    //MARK: - API Index 13(실시간, NEW 작품 조회 API)
    
    var realTimeAndNewProductData: RealTimeAndNewProductData?
    
    func getRealTimeAndNewProductData(completion: @escaping (RealTimeAndNewProductData) -> Void) {
        AF.request(Keys.baseURL + "/products/real-time",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: Keys.jwtHeaders
        ).responseDecodable(of: RealTimeAndNewProductData.self) { result in
            
            switch result.result {
            case .success(let success):
                self.realTimeAndNewProductData = success
                completion(self.realTimeAndNewProductData!)
                
            case.failure(let error):
                debugPrint(error)
            }
            
        }
    }
    
    //MARK: - API Index 15 (작품 찜하기 API)
    func postDibsonData(completion: @escaping (CardResigsterResult) -> Void) {
        AF.request("https://prod.idus-b.shop/products/dibs/\(UserInfo.shared.useridx!)/\(DetailViewController.productIdx!)",
                   method: .post,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: Keys.jwtHeaders
        ).responseDecodable(of: CardResigsterResult.self) { result in
            
            switch result.result {
            case .success(let success):
                completion(success)
                
            case.failure(let error):
                debugPrint(error)
            }
            
        }
    }
    //MARK: - API Index 16 (작품 찜 취소 API)
    func patchDibsonData(completion: @escaping (CardResigsterResult) -> Void) {
        AF.request("https://prod.idus-b.shop/products/dibs/\(UserInfo.shared.useridx!)/\(DetailViewController.productIdx!)",
                   method: .patch,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: Keys.jwtHeaders
        ).responseDecodable(of: CardResigsterResult.self) { result in
            
            switch result.result {
            case .success(let success):
                completion(success)
                
            case.failure(let error):
                debugPrint(error)
            }
            
        }
    }


    //MARK: - API Index 28 유저 신용카드 등록
    func postCardResigster(completion: @escaping (CardResigsterResult) -> Void, vc: CardResigsterViewController) {
        
        let parameters: Parameters = [
            "userIdx": "\(UserInfo.shared.useridx!)",
            "cardKind": "I",
            "cardNumber": "\(vc.cardNumber.text!)",
            "cardDate": "\(vc.cardDate.text!)",
            "cardBirth": "\(vc.cardBirth.text!)",
            "cardBN": "\(vc.cardBN.text!)",
            "cardPw": "\(vc.cardPw!.text!)"
        ]
        AF.request(
            "https://prod.idus-b.shop/users/credit-card",
            method: .post,
            parameters: parameters, encoding: JSONEncoding.default,headers: Keys.jwtHeaders)
        .responseDecodable(of: CardResigsterResult.self) { response in
            switch response.result {
            case .success(let result):
                print(result)
                completion(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postBuyProduct(completion: @escaping (CardResigsterResult) -> Void, vc: FinalViewController) {
        
        let parameters: Parameters = [
            "productIdx" : "\(DetailViewController.productIdx!)",
            "optionContent" : "",
            "productCount" : "\(vc.productCount.text!)",
            "totalMoney" : "\(vc.allallprice.text?.components(separatedBy: ["원"]).joined() ?? "")",
            "shippingAddressCount" : "1",
            "cardIdx" : "1",
            "paymentInfo" : "일시불",
            "requestContent" : "\(vc.require.text!)"
        ]
        AF.request(
            "https://prod.idus-b.shop/products/purchase/\(UserInfo.shared.useridx!)",
            method: .post,
            parameters: parameters, encoding: JSONEncoding.default,headers: Keys.jwtHeaders)
        .responseDecodable(of: CardResigsterResult.self) { response in
            switch response.result {
            case .success(let result):
                debugPrint(result)
                completion(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMyBuy(completion: @escaping (MyBuyDetailData) -> Void) {
        
        AF.request("https://prod.idus-b.shop/users/purchase-log/\(UserInfo.shared.useridx!)",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: Keys.jwtHeaders
        ).responseDecodable(of: MyBuyDetailData.self) { result in
            
            switch result.result {
            case .success(let success):
                completion(success)
            case.failure(let error):
                debugPrint(error)
            }
            
        }
    }
    
    //MARK: - API Index 41(작품 찜 목록 조회)
    func getMyDibs(completion: @escaping (MyDibsData) -> Void) {
        
        AF.request("https://prod.idus-b.shop/users/dibs-list/\(UserInfo.shared.useridx!)",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: Keys.jwtHeaders
        ).responseDecodable(of: MyDibsData.self) { result in
            
            switch result.result {
            case .success(let success):
                completion(success)
            case.failure(let error):
                debugPrint(error)
            }
            
        }
    }
}

