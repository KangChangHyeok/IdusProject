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
import FSPagerView

class DetailViewController: UIViewController {
    
    //MARK: - IBOutlet, property
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productImages: FSPagerView! {
        didSet {
            self.productImages.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "productImages")
            self.productImages.dataSource = self
        }
    }
    @IBOutlet weak var sellerNickName: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDiscountRate: UILabel!
    @IBOutlet weak var productDiscountPrice: UILabel!
    @IBOutlet weak var productRealPrice: UILabel!
    @IBOutlet weak var productSavePoint: UILabel!
    @IBOutlet weak var deliveryView: UIView! {
        didSet {
            self.deliveryView.layer.borderWidth = 2
            self.deliveryView.layer.borderColor = UIColor.lightGray.cgColor
            self.deliveryView.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var reviewCollectionView: UICollectionView! {
        didSet {
            reviewCollectionView.register(UINib(nibName: ReviewCell.className, bundle: nil), forCellWithReuseIdentifier: ReviewCell.cellId)
            reviewCollectionView.dataSource = self
            reviewCollectionView.delegate = self
        }
    }
    @IBOutlet weak var buyView: UIView!
    @IBOutlet weak var buyButton: UIButton! {
        didSet {
            buyButton.backgroundColor = .idusMainColor
            buyButton.layer.cornerRadius = 4
        }
    }
    private let dataManager = DataManager()
    private var detailResult: DetailResult?
    var reviewCount = 0
    var reviewStarRating = [Double]()
    var reviewText = [String]()
    var productIdx: Int?
    
    //MARK: - override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValue()
    }
    func setupValue() {
        dataManager.getDetailData(productIdx: self.productIdx) { data in
            self.detailResult = data.result
            self.sellerNickName.text = self.detailResult?.sellerInfo?.sellerNickname
            if (Double(((self.detailResult?.sellerInfo?.reviewStarRating)!)) / Double((self.detailResult?.sellerInfo?.count)!)).isNaN {
                self.starRating.rating = 0.0
                self.starRating.text = ""
            } else {
                self.starRating.rating = (round(Double((self.detailResult?.sellerInfo?.reviewStarRating)!) / Double((self.detailResult?.sellerInfo?.count)!)) * 10) / 10
            }
            self.starRating.text = self.starRating.rating.description
            self.productTitle.text = self.detailResult?.product?.productTitle
            self.productDiscountRate.text = self.detailResult?.product?.productDiscountRate?.description
            self.productDiscountPrice.text = self.detailResult?.product?.productDiscountPrice
            self.productRealPrice.attributedText = self.detailResult?.product?.productRealPrice?.strikeThrough()
            self.productSavePoint.text = (self.detailResult?.product?.productSavePoint!.description ?? "") + "P"
            self.productImages.reloadData()
        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case buyButton:
            // 바텀 시트로 쓰일 뷰컨트롤러 생성
            let buyPopvc = storyboard?.instantiateViewController(withIdentifier: "BuyPopupViewController") as! BuyPopupViewController
            
            // MDC 바텀 시트로 설정
            let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: buyPopvc)
            bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 200
            buyPopvc.productPrice = self.productDiscountPrice.text
            // 보여주기
            present(bottomSheet, animated: true)
        default:
            break
        }
    }
}
//MARK: - extension

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
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {return CGSize()}
        flow.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let height: CGFloat = collectionView.frame.height - 10
        let width: CGFloat = (collectionView.frame.width / 1.3) - 20
        return CGSize(width: width, height:height)
    }
}
extension DetailViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        guard let count = detailResult?.productImages.count else {return 0}
        return count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "productImages", at: index)
        guard let image = self.detailResult?.productImages[index].productImageUrl else {return FSPagerViewCell()}
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.kf.setImage(with: URL(string: image))
        return cell
    }
}


