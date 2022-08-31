//
//  MyBuyTableViewCell.swift
//  라이징캠프-6기-아이디어스-iOS-카일
//
//  Created by 강창혁 on 2022/07/08.
//

import UIKit

class MyBuyTableViewCell: UITableViewCell {

    static let cellId = "MyBuyTableViewCell"
    static let className = "MyBuyTableViewCell"
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productIdx: UILabel!
    @IBOutlet weak var sellerNickname: UILabel!
    @IBOutlet weak var shippingDate: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var requestContent: UILabel!
    @IBOutlet weak var paymentInfo: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var totalMoney: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
