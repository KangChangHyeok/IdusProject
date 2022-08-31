//
//  CardResigsterViewController.swift
//  라이징캠프-6기-아이디어스-iOS-카일
//
//  Created by 강창혁 on 2022/07/08.
//

import UIKit

class CardResigsterViewController: UIViewController, UITextFieldDelegate {
    
    let postData = DataManager()
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardDate: UITextField!
    @IBOutlet weak var cardBirth: UITextField!
    @IBOutlet weak var cardBN: UITextField!
    @IBOutlet weak var cardPw: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        cardNumber.delegate = self
        cardDate.delegate = self
        cardBirth.delegate = self
        cardBN.delegate = self
        cardPw.delegate = self
        buyButton.backgroundColor = .idusmainColor
    }
    

    
    @IBAction func resigsterCard(_ sender: UIButton) {
        
        postData.postCardResigster(completion: { ResponseResult in
            print(ResponseResult)
        }, vc: self)
        self.dismiss(animated: true)
    }
    

}
