//
//  DetailViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/05.
//

import UIKit
import Kingfisher
import Cosmos
import MaterialComponents.MaterialBottomSheet

class DetailViewController: UIViewController {
    let getdata = NetworkManager.shared
    //todayView에서 productIdx를 넘겨 받음
    static var productIdx: Int?
    
    var images = [String]()
    var reviewCount = 0
    var reviewStarRating = [Double]()
    var reviewText = [String]()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sellerNickName: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDiscountRate: UILabel!
    @IBOutlet weak var productDiscountPrice: UILabel!
    @IBOutlet weak var productRealPrice: UILabel!
    @IBOutlet weak var productSavePoint: UILabel!
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    
    
    //최히단 구매하기 뷰
    @IBOutlet weak var buyView: UIView!
    @IBOutlet weak var buyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        SetData()
        setUI()
    }
    func SetData() {
        getdata.getDetailData { DetailData in
            guard let detailData = DetailData.result else {return}
            for i in 0...detailData.productImages.count - 1 {
                self.images.append(detailData.productImages[i].productImageUrl!)
            }
            self.imageView.kf.setImage(with: URL(string: self.images[0]))
            self.sellerNickName.text = detailData.sellerInfo?.sellerNickname
            if (Double((detailData.sellerInfo?.reviewStarRating)!) / Double((detailData.sellerInfo?.count)!)).isNaN {
                self.starRating.rating = 0.0
                self.starRating.text = ""
            } else {
                self.starRating.rating = Double((detailData.sellerInfo?.reviewStarRating)!) / Double((detailData.sellerInfo?.count)!)
            }
            self.starRating.text = self.starRating.rating.description
            
            
            self.productTitle.text = detailData.product?.productTitle!
            self.productDiscountRate.text = detailData.product?.productDiscountRate?.description
            self.productDiscountPrice.text = detailData.product?.productDiscountPrice?.description
            self.productRealPrice.text = detailData.product?.productRealPrice?.description
            self.productRealPrice.attributedText = self.productRealPrice.text?.strikeThrough()
            self.productSavePoint.text = (detailData.product?.productSavePoint!.description ?? "") + "P"
            
            //상세보기 리뷰
            self.reviewCount = detailData.productReview!.count
            if self.reviewCount == 0 {
                print("리뷰 없음")
            } else {
                for i in 0...self.reviewCount - 1 {
                    self.reviewStarRating.append(Double(detailData.productReview![i].reviewStarRating!))
                    if self.reviewStarRating[i].isNaN {
                        self.reviewStarRating[i] = 0.0
                    }
                }
                for i in 0...self.reviewCount - 1 {
                    self.reviewText.append(detailData.productReview![i].reviewContent!)
                }
                self.reviewCollectionView.reloadData()
            }
            
        }
        
    }
    
    func setUI() {
        self.deliveryView.layer.borderWidth = 2
        self.deliveryView.layer.borderColor = UIColor.lightGray.cgColor
        self.deliveryView.layer.cornerRadius = 4
        buyButton.backgroundColor = .idusmainColor
        buyButton.layer.cornerRadius = 4
        
    }
    
    
    func setCollectionView() {
        reviewCollectionView.register(UINib(nibName: ReviewCell.className, bundle: nil), forCellWithReuseIdentifier: ReviewCell.cellId)
        reviewCollectionView.dataSource = self
        reviewCollectionView.delegate = self
    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        // 바텀 시트로 쓰일 뷰컨트롤러 생성
        let vc = storyboard?.instantiateViewController(withIdentifier: "BuyPopupViewController") as! BuyPopupViewController
        
        // MDC 바텀 시트로 설정
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 200
        vc.senderPrice = self.productDiscountPrice.text!.description
        // 보여주기
        present(bottomSheet, animated: true) {
        }
    }
    
    
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        presentFromLeft()
        self.dismiss(animated: false)
    }
    @IBAction func dibsonButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            getdata.postDibsonData { CardResigsterResult in
                print(CardResigsterResult)
            }
        }
        else {
            getdata.patchDibsonData { CardResigsterResult in
                print(CardResigsterResult)
            }
        }
        
    }
    @IBAction func goCart(_ sender: UIBarButtonItem) {
    }
}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.cellId, for: indexPath) as! ReviewCell
        cell.starRating.rating = Double(self.reviewStarRating[indexPath.row])
        cell.reviewText.text = self.reviewText[indexPath.row]
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: -2, height: 2)
        cell.layer.shadowRadius = 3
        return cell
    }
    
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        flow.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let height: CGFloat = collectionView.frame.height - 10
        let width: CGFloat = (collectionView.frame.width / 1.3) - 20
        
        
        
        return CGSize(width: width, height:height)
    }
}


