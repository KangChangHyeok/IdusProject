//
//  FinalViewController.swift
//  라이징캠프-6기-아이디어스-iOS-카일
//
//  Created by 강창혁 on 2022/07/07.
//

import UIKit

class FinalViewController: UIViewController {
    
    let postdata = DataManager()
    
    static var text = ""
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var writer: UILabel!
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var allPrice: UILabel!
    @IBOutlet weak var require: UILabel!
    @IBOutlet weak var allallprice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingUI()
        sD()
        
    }
    
    func SettingUI() {
        
        
        buyButton.backgroundColor = .idusmainColor
        buyButton.layer.cornerRadius = 4
    }
    
    func sD() {
        postdata.getDetailData { DetailData in
            self.writer.text = DetailData.result?.sellerInfo?.sellerNickname?.description
            self.product.text = DetailData.result?.product?.productTitle?.description
            self.productCount.text = BuyViewController.stepperValue.description
            self.price.text = BuyViewController.stepperPriceValue.description
            self.allPrice.text = BuyViewController.stepperPriceValue.description
            self.require.text = FinalViewController.text
            self.allallprice.text = (BuyPopupViewController.allPrice + 3000).description + "원"
        }
    }
    @IBAction func changeButtonTapped(_ sender: UIButton) {
        
        
    }
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true)
    }
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        
        postdata.postBuyProduct(completion: { CardResigsterResult in
            debugPrint(CardResigsterResult)
        }, vc: self)
        
        self.dismiss(animated: true) {
            guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
        }
    }
}
