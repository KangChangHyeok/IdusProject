//
//  ProductViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/30.
//

import UIKit
import Tabman
import Pageboy

class ProductViewController: TabmanViewController {

//    var lastContentsOffset: CGFloat = 0.0
    
    @IBOutlet weak var tabV: UIView!
    private var viewControllers: [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let todayVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TodayViewController") as! TodayViewController
        let realTimeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RealTimeViewController") as! RealTimeViewController
        let newVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
                   
        viewControllers.append(todayVC)
        viewControllers.append(realTimeVC)
        viewControllers.append(newVC)
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.contentMode = .fit
        bar.indicator.backgroundColor = .idusmainColor
        
        bar.buttons.customize { button in
            button.selectedTintColor = .idusmainColor
        }
        addBar(bar, dataSource: self, at: .custom(view: tabV, layout: nil))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
          
        let image = UIImage(named: "nav_titleimage.png")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }

}



extension ProductViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "투데이")
        case 1:
            return TMBarItem(title: "실시간")
        case 2:
            return TMBarItem(title: "New")
        default:
            let title = "Page\(index)"
            return TMBarItem(title: title)
        }
    }
    
    
}
