//
//  BuyPopupViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/07.
//

import UIKit

class BuyPopupViewController: UIViewController {
    
    //MARK: - IBOutlet, property
    
    @IBOutlet weak var productcount: UIStepper!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var buyButton: UIButton! {
        didSet {
            buyButton.backgroundColor = .idusMainColor
            buyButton.layer.cornerRadius = 4
        }
    }
    var productPrice: String?
    var senderValue = 0.0
    static var allPrice = 0
    
    //MARK: - override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBAction
    
    @IBAction func presentStepper(_ sender: UIStepper) {
        guard let productPrice = productPrice else {return}
        BuyPopupViewController.allPrice = (Int(sender.value - 1.0) * Int(productPrice.components(separatedBy: [","]).joined())!)
        price.text = (Int(sender.value - 1.0) * Int(productPrice.components(separatedBy: [","]).joined())!).description + "원"
        self.senderValue = sender.value
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case buyButton:
            if price.text == "" , price.text == "0원" {
                let alert = UIAlertController(title: "수량이 선택되지 않았습니다.", message: "구매하실 작품의 수량을 확인해 주세요!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            } else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "BuyNavigationController") as! BuyNavigationController
                vc.modalPresentationStyle = .fullScreen
                BuyViewController.stepperValue = Int(self.senderValue)
                BuyViewController.stepperPriceValue = self.price.text!
                present(vc, animated: true)
            }
        default:
            break
        }
    }
}
