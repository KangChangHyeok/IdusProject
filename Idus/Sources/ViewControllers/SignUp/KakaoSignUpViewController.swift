//
//  KakaoLoginPopUpViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/26.
//

import UIKit

class KakaoSignUpViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var background: UIImageView! {
        didSet {
            background.image = backgroundImage
        }
    }
    @IBOutlet weak var backButton: UIButton!
    
    var backgroundImage: UIImage?
    
    //MARK: - override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBAction
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case backButton:
            self.dismiss(animated: true)
        default:
            break
        }
    }
}
