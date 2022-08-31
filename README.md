
# 앱 클론 프로젝트(Idus)

> 시연영상 구글드라이브 링크 https://drive.google.com/file/d/1KC58wWk9wDrRniHWIbiJulD3ryfI9FEH/view?usp=sharing
<details>
<summary>개발 일지</summary>
<div markdown="1">

## 6.25일
1. local repo와 remote repo 연결 세팅 및 확인 완료
2. 사전에 보내준 템플릿을 참고하여 프로젝트 초기 세팅 완료
3. 프레임워크 add Packages 완료(Kingfihser, Alamofire, PagingKit)

## 6.26일
1. splashView 레이아웃 80% 완성
2. 기본적인 하단 tabbarController 구현
3. SceneDelegate활용한 Login Logic 구현

## 6.27일
1. splashView 레이아웃 완성 완료
2. splashView background image transition 구현 완료.
3. 다른 방법으로 가입하기 -> 이메일 회원가입 뷰 구현
4. 전체적으로 코드 

## 6.28일
1. 이메일 회원가입 네트워크 api 엮는 작업(post) -> 중간에 계속 막히는 부분이 생겨 우노한테 피드백 요청한 

## 6.29일
1. 피드백
  - UI완성도 매우 훌륭하다.
  - 완벽한 기능구현에 메달리지 말고 70%정도의 성능 구현을 목표로 하기
  - 다음주 2차 피드백까지 구매 기능 구현 목표로 할것
2. 이메일로 회원가입하기 api post 작업 앱에 구현 완료.

## 6.30일
1. 로그아웃 로직 관련 api 엮는중.. 
2. 앱 하단의 작품 탭의 상단 탭바 구현 및 컨트롤러 연동 완료.

## 7월 1일
1. 로그아웃 로직 관련 patch 시도할때 path 설정 이슈.
  - 오늘 이거 하나에 시간 다 뺏겼는데, 결국 해결 못함.. 앞으로는 안된다 싶으면 일단 다른 작업 먼저 할것. UI작업도 할게 산더미..

## 7월 2일
1. 투데이 탭 최상단 배너 스크롤 기능 구현 완료
2. 로그아웃 api 적용 완료

## 7월 3일
1. 투데이 탭 배너 api 적용중.

## 7월 4일
1. 투데이 탭 배너 이미지 api 적용 완료.
2. 비회원 로그인시 alamofire decoding 안되는 이슈 해결 
3. 투데이 탭에서 보여줄 3개 카테고리중 1개 레이아웃 구성 및 api 적용 완료.

## 7월 5일
1. 작품 - 투데이 탭 구현 완료
2. 작품 - 실시간 탭 구현 완료
3. 화면에서 cell 터치시 뷰 컨트롤러 전환 구현 완료.(상세보기 탭)

## 7월 6일
1.피드백
  - 구매 로직 구현할 것.
  - 레이아웃 작업할때 padding값은 중요시 생각하고 작업하기(디자인적 요소)
2. 상세화면 페이지 구현 대부분 완료. 하단 뷰에 구매하기 버튼 추가하여 구매 로직 작업중.

## 7월 7일
1. 최종 커밋 완료.
2. 서버 접속 이슈로 API를 엮지 못해 구매로직 구현 미완료.

본 템플릿의 저작권은 (주) 소프트스퀘어드에 있습니다. 무단 배포를 금합니다.

</div>
</details>

## 프로젝트 소개
- Idus 클론 프로젝트입니다.
- 실제 업무 경험을 위한 목적으로 서버 개발자분과 함께 진행했습니다.

## 기술 스택
### Swift
- Swift 5
- UIKit
### 뷰 드로잉
- Interface builder : Storyboard

### 백엔드
- Local DB: UserDefault
### 네트워킹
- Alamofire
### 개발 아키텍처 및 디자인 패턴
- MVC
### 이외에 사용한 오픈소스
- Kingfisher
- Cosmos
- FSPagerView
- Pageboy
- Tabman
- MaterialComponents/BottomSheet
## 기능
- 실제 어플과 기능적으로 비교했을때, 자체 회원가입 기능과 구매 로직 구현을 완료했습니다.  

## 고민 & 구현 방법
### 배경화면 애니매이션 기능
첫 화면 진입시 배경화면의 이미지가 일정 시간 간격으로 전환되는 기능입니다.  

<details>
<summary>코드 보기</summary>
<div markdown="1">

처음에 애니매이션 관련 동작 코드를 viewDidLoad()와 viewWillAppear()에서 작성할 경우 실행되지 않았습니다.  
애니매이션 관련 코드는 viewDidAppear, 즉 화면이 나타나고 나서 실행되어야 작동한다는 것을 배웠습니다.  
Timer와 UIView의 transition 를 활용하여 시간을 3초로 맞추어 기능을 구현했습니다.  

```swift
override func viewDidAppear(_ animated: Bool) {
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { timer in
            UIView.transition(with: self.transitionV, duration: 3, options: .transitionCrossDissolve, animations: {
                self.transitionV.image = self.images.randomElement() as! UIImage
            }, completion: nil)
        })
    }
```

</div>
</details>

### 회원가입 기능
escaping Closer를 활용하여 서버와 통신하는 함수를 만들어 데이터를 활용하였습니다.
버튼을 누를 경우 서버와 통신하여 사용자의 정보를 서버에 등록하고, 메인 화면으로 넘어가게 됩니다.
<details>
<summary>코드 보기</summary>
<div markdown="1">
  
```swift
//escaping closer를 활용한 데이터를 가져오는 함수
 func signUpResultNetWork(completion: @escaping (ResponseResult) -> Void) {
        let parameters: Parameters = [
            "userName": "\(self.nameTF.text!)",
            "userEmail": "\(self.emailTF.text!)",
            "userPw": "\(self.pwTF.text!)",
            "userPhoneNumber": "\(self.phoneTF.text!)"
        ]
        AF.request(
            Keys.baseURL + "/users",
            method: .post,
            parameters: parameters, encoding: JSONEncoding.default,headers: Keys.headers)
        .responseDecodable(of: ResponseResult.self) { response in
            switch response.result {
            case .success(let result):
                
                print(result)
                completion(result)
            case .failure(let error):
                print(error)
            }
        }
    } 

  //버튼을 누를때 함수를 실행시켜 서버에 사용자의 정보를 저장하고, 메인화면으로 화면 전환
@IBAction func signUpButtonTapped(_ sender: UIButton) {
        signUpResultNetWork { signUpResult in
            if signUpResult.isSuccess! == true {
                print("회원가입이 완료되었습니다.")
                self.dismiss(animated: true) {
                    guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
                }
            }
            else {
                
            }
        }
        
    }
```

</div>
</details>


### 구매하기 
escaping Closer를 활용하여 서버와 통신하는 함수를 만들어 데이터를 활용하였습니다.  
사용자의 구매정보가 담겨있는 정보를 활용하여 데이터 통신을 시도합니다.
<details>
<summary>코드 보기</summary>
<div markdown="1">
  
```swift
  //vc파라미터의 값을 활용하여 parameter의 값을 전달하고 post
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
 
```

</div>
</details>

## 프로젝트를 통해 배운것

### CollectionView in TableViewCell


<details>
<summary>코드 보기</summary>
<div markdown="1">

UI 디자인이 복잡하진 않았지만, 일정한 구역마다 상품의 리스트를 보여주는 형식이어서 테이블뷰안에 컬렉션뷰를 넣는 방식으로 구현했습니다.  
ColletcionViewCell의 index를 tableViewCell에게 전달해주기 위해서,  
Custom Protocol를 구현하고, TableViewCell안의 CollectionViewDelegate의 didSelectItemAt함수에서 함수가 실행될 수 있도록 구현했습니다.  
이 로직을 만들면서 delegate패턴에 대해 좀더 이해할수 있었습니다.

```swift
  
  //CollectionView의 index값을 전달받기 위한 protocol 선언
  
  protocol CollectionViewCellDelegate {
    func selectedCell(_ productIdx: Int)
}
  // TableViewCell안에있는 CollectionView에서 Cell이 선택되었을때의 해당하는 index 값을 전달
  
  extension CategoryCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedCell(productIdx[indexPath.row])
        productNameImageView.kf.setImage(with: URL(string: self.images[indexPath.row]))
    }
}

  //해당 프로토콜 타입의 delegate 변수 선언
  var delegate: CollectionViewCellDelegate?
  
  //TableView의 cellForRowAt 함수 안에서 cell Delegate 채택
  
  cell.delegate = self
  
  // 이후 데이터를 활용하기 위한 로직 구현
  
  extension TodayViewController: CollectionViewCellDelegate {
    func selectedCell(_ productIdx: Int) {
        guard let detailViewNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewNavigationController") as? DetailViewNavigationController else {return}
        detailViewNavigationController.modalPresentationStyle = .fullScreen
        DetailViewController.productIdx = productIdx
        presentFromRight()
                present(detailViewNavigationController, animated: false) {
                    
        }
    }
}
```

</div>
</details>

### Singleton Pattern


<details>
<summary>코드 보기</summary>
<div markdown="1">

간단한 정보이지만 여러군데에서 쓰이는 정보를 쉽게 활용하기 위해 Singleton Pattern을 활용하였습니다.  

```swift
class UserInfo {
    static let shared = UserInfo()
    
    var useridx: Int?
    var name: String?
    var jwt: String?
    
    
}
```

</div>
</details>

### isNaN

<details>
<summary>코드 보기</summary>
<div markdown="1">

서버의 데이터를 받아와 사용하던 도중, 데이터가 없는 상태에서 계산이 실행되어 NaN으로 데이터를 받는 경우가 있었습니다.  
이 타입은 단어 그대로 숫자가 아닌(not a number) 타입이기때문에 데이터를 활용하는데 어려움을 겪었습니다.  
if문의 조합과 isNaN 이라는 계산속성의 활용으로 값이 없을경우, 기본값으로 0이나 0.0을 제시하여 해결하였습니다.  

```swift
//isNaN은 읽기전용 계산 프로퍼티로 Bool타입을 반환합니다. true일 경우 값이 없다는 뜻이므로 기본값을 제시합니다.
if (Double((detailData.sellerInfo?.reviewStarRating)!) / Double((detailData.sellerInfo?.count)!)).isNaN {
                self.starRating.rating = 0.0
                self.starRating.text = ""
            // 값이 NaN이 아닌경우 값을 불러와 계산을 실행합니다.
            } else {
                self.starRating.rating = Double((detailData.sellerInfo?.reviewStarRating)!) / Double((detailData.sellerInfo?.count)!)
            }
```

</div>
</details>

### API 명세서 활용
처음으로 API 명세서를 바탕으로한 서버를 활용하여 프로젝트를 진행하면서 데이터를 활용하는 부분에서 많은 것을 배울수 있었습니다.
### 협업 능력
이번 프로젝트가 저의 첫 팀 프로젝트였습니다. 이번 프로젝트를 다른분야의 개발자분과 같이 진행하면서 협업이 중요하다는 것을 배울 수 있었습니다.  
자신의 기본적인 실력이 뒷받침 되어야 다른 분야의 사람과 소통하고 제가 요구 하는것을 정확히 표현할수 있다는것을 배웠습니다.
