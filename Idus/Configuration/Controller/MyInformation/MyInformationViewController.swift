//
//  MyInformationViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/30.
//

import UIKit
import Alamofire
import SwiftUI
class MyInformationViewController: UIViewController {
    
    let dataManager = DataManager()
    @IBOutlet weak var pointStackView: UIStackView!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var cardResigsterButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhoneNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setui()
//        dataManager.getUserInformation { UserInformationData in
//            self.userName.text = UserInformationData.result?.userName?.description
////            self.userImage.kf.setImage(with: URL(string: (UserInformationData.result?.userImageURL!.description)!))
//            self.userEmail.text = UserInformationData.result?.userEmail?.description
//            self.userPhoneNumber.text = UserInformationData.result?.userPhoneNumber?.description
//        }
    }
    func setui() {
        logOutButton.backgroundColor = .idusmainColor
        logOutButton.layer.cornerRadius = 4
        cardResigsterButton.backgroundColor = .idusmainColor
        cardResigsterButton.layer.cornerRadius = 4
        pointStackView.backgroundColor = .lightGray
        userImage.layer.cornerRadius = userImage.frame.height / 2
    }
    
    @IBAction func LogOutButtonTapped(_ sender: UIButton) {
        
        dataManager.postLogOut { LogOutResult in
        }
        
        let alert = UIAlertController(title: "로그아웃되었습니다!", message: "아이디어스를 이용해 주셔서 감사합니다!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { UIAlertAction in
            self.dismiss(animated: true) {
                guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "SplashViewController") as? LoginViewController else { return }
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)

        
        
    }
    @IBAction func cartResigsterButtonTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardResigsterViewController") as! CardResigsterViewController
        
        present(vc, animated: true) {
            
        }
    }
    @IBAction func myBuyButtonTapped(_ sender: UIButton) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyBuyViewNavigationController") as! MyBuyViewNavigationController
        vc.modalPresentationStyle = .fullScreen
        presentFromRight()
        present(vc, animated: false) {
            
        }
    }
    @IBAction func MyDibsButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyDibsNavigationController") as! MyDibsNavigationController
        vc.modalPresentationStyle = .fullScreen
        presentFromRight()
        present(vc, animated: false) {
            
        }
        
    }
}
