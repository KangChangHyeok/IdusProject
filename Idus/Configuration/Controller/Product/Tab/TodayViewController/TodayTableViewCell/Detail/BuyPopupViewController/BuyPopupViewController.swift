//
//  BuyPopupViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/07.
//

import UIKit

class BuyPopupViewController: UIViewController {

    @IBOutlet weak var productcount: UIStepper!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var butButton: UIButton!
    var senderPrice = ""
    var senderValue = 0.0
    static var allPrice = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        butButton.backgroundColor = .idusmainColor
        butButton.layer.cornerRadius = 4
        
    }

    @IBAction func presentStepper(_ sender: UIStepper) {
        BuyPopupViewController.allPrice = (Int(sender.value - 1.0) * Int(senderPrice.components(separatedBy: [","]).joined())!)
        price.text = (Int(sender.value - 1.0) * Int(senderPrice.components(separatedBy: [","]).joined())!).description + "원"
        self.senderValue = sender.value
    }
    @IBAction func TapBuyButton(_ sender: UIButton) {
        
        if price.text == "" || price.text == "0원" {
            let alert = UIAlertController(title: "수량이 선택되지 않았습니다.", message: "구매하실 작품의 수량을 확인해 주세요!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "BuyNavigationController") as! BuyNavigationController
            vc.modalPresentationStyle = .fullScreen
            BuyViewController.stepperValue = Int(self.senderValue)
            BuyViewController.stepperPriceValue = self.price.text!
            present(vc, animated: true) {
                
            }
        }
        
        
    }
}
