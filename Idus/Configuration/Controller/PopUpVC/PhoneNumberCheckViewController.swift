//
//  PhoneNumberCheckViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/27.
//

import UIKit
import Alamofire

class PhoneNumberCheckViewController: UIViewController {
    
    @IBOutlet weak var requestView: UIView!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var requestButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestView.layer.cornerRadius = 10
        phoneNumberTF.delegate = self
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    @IBAction func requestButtonTapped(_ sender: UIButton) {
        
    }
    
}
extension PhoneNumberCheckViewController: UITextFieldDelegate {
    
}

