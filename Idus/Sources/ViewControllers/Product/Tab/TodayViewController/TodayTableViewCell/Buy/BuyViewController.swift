//
//  BuyViewController.swift
//  라이징캠프-6기-아이디어스-iOS-카일
//
//  Created by 강창혁 on 2022/07/07.
//

import UIKit
import Kingfisher
class BuyViewController: UIViewController {
    let getdata = NetworkManager.shared
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var need: UITextView!
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var deliveryPrice: UILabel!
    @IBOutlet weak var bottomPrice: UILabel!
    @IBOutlet weak var bottomdeliveryPrice: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var productIdx: Int = 0
    
    static var stepperValue = 0
    static var stepperPriceValue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productIdx = DetailViewController.productIdx!
        setData()
        setUi()
        print(productIdx)
    }
    
    func setData() {
        getdata.getDetailData { DetailData in
            self.sellerName.text = DetailData.result?.sellerInfo?.sellerNickname?.description
            self.image.kf.setImage(with: URL(string: DetailData.result?.productImages[0].productImageUrl?.description ?? ""))
            self.productName.text = DetailData.result?.product?.productTitle?.description
            
            self.productCount.text = ((BuyViewController.stepperValue) - 1).description
            self.price.text = BuyViewController.stepperPriceValue.description
            self.finalPrice.text = BuyViewController.stepperPriceValue.description
            self.bottomPrice.text = BuyViewController.stepperPriceValue.description
        }
    }
    
    func setUi() {
        buyButton.backgroundColor = .idusmainColor
        buyButton.layer.cornerRadius = 4
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
    }
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FinalNavigationController") as! FinalNavigationController
        
        vc.modalPresentationStyle = .fullScreen
        FinalViewController.text = self.textView.text
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func `return`(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
