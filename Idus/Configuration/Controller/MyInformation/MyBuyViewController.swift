//
//  MyBuyViewController.swift
//  라이징캠프-6기-아이디어스-iOS-카일
//
//  Created by 강창혁 on 2022/07/08.
//

import UIKit
import Kingfisher
class MyBuyViewController: UIViewController {
    let getdata = DataManager()
    @IBOutlet weak var tableView: UITableView!
    

    
    var buyCount = 0
    var productIdxs = [Int]()
    var productName = [String]()
    
    var productImageUrls = [Int]()
    var realProductImageUrls = [String]()
    
    var shoppingDates = [String]()
    var sellerNickNames = [String]()
    var productCounts = [Int]()
    var totalMoneys = [Int]()
    var cardNumbers = [String]()
    var paymentInfo = [String]()
    var requestContent = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getdata.getMyBuy { MyBuyDetailData in
            print(MyBuyDetailData)
            self.buyCount = MyBuyDetailData.result!.count
            for i in 0...MyBuyDetailData.result!.count - 1 {
                self.productIdxs.append(MyBuyDetailData.result![i].productIdx!)
                self.productImageUrls.append(self.productIdxs[i])
                self.sellerNickNames.append(MyBuyDetailData.result![i].sellerNickname!)
                self.shoppingDates.append(MyBuyDetailData.result![i].shippingDate!)
                self.productCounts.append(MyBuyDetailData.result![i].productCount!)
                self.requestContent.append(MyBuyDetailData.result![i].requestContent!)
                self.paymentInfo.append(MyBuyDetailData.result![i].paymentInfo!)
                self.cardNumbers.append(MyBuyDetailData.result![i].cardNumber!)
                self.totalMoneys.append(MyBuyDetailData.result![i].totalMoney!)
            }
            self.tableView.reloadData()
        }

        tableView.register(UINib(nibName: MyBuyTableViewCell.className, bundle: nil), forCellReuseIdentifier: MyBuyTableViewCell.cellId)
    }
    @IBAction func backbuttonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false)
    }
    
}


extension MyBuyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(buyCount)
        return buyCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyBuyTableViewCell.cellId) as! MyBuyTableViewCell
        cell.sellerNickname.text = self.sellerNickNames[indexPath.row]
        cell.shippingDate.text = self.shoppingDates[indexPath.row]
        cell.productCount.text = self.productCounts[indexPath.row].description
        cell.requestContent.text = self.requestContent[indexPath.row]
        cell.cardNumber.text = self.cardNumbers[indexPath.row]
        cell.totalMoney.text = self.totalMoneys[indexPath.row].description
        cell.productIdx.text = self.productIdxs[indexPath.row].description
        return cell
    }
    
}

extension MyBuyViewController: UITableViewDelegate {
    
}
