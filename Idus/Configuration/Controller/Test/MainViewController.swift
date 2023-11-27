//
//  MainViewController.swift
//  Idus
//
//  Created by 강창혁 on 2023/11/03.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var searchView: UIView! {
        didSet {
            searchView.layer.cornerRadius = 4
            searchView.layer.borderColor = UIColor.lightGray.cgColor
            searchView.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet weak var cartButton: UIButton! {
        didSet {
            cartButton.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var todayButton: UIButton! {
        didSet {
            todayButton.tag = 0
            todayButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var foodButton: UIButton! {
        didSet {
            foodButton.tag = 1
            foodButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var newButton: UIButton! {
        didSet {
            newButton.tag = 2
            newButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var underLine: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    private var selectedButtonTag = 0
    private var pageViewController: MainPageViewController!
    private var pages = [UIViewController]()
    private lazy var buttons = [todayButton, foodButton, newButton]
    private var animator: UIViewPropertyAnimator?
    
    //MARK: - Lifecycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MainPageViewController,
           segue.identifier == "PageViewController" {
            self.pageViewController = vc
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewControllers()
    }
    
    func configurePageViewControllers() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let todayViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(withIdentifier: "A" ) as! TodayViewController
        let foodViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(withIdentifier: "B" ) as! FoodViewController
        let newViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(withIdentifier: "C" ) as! NewViewController
        
        [todayViewController, foodViewController, newViewController].forEach { viewController in
            pages.append(viewController)
        }
        
        pageViewController.setViewControllers([todayViewController], direction: .forward, animated: false)
    }
    
    @objc func buttonDidTap(sender: UIButton) {
        guard selectedButtonTag > sender.tag else {
            pageViewController.setViewControllers([pages[sender.tag]], direction: .forward, animated: true)
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0) {
                self.view.removeConstraint(self.leadingConstraint)
                let leadingConstraint = self.underLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sender.frame.origin.x)
                self.leadingConstraint = leadingConstraint
                leadingConstraint.isActive = true
                self.view.layoutIfNeeded()
                
                self.selectedButtonTag = sender.tag
            }
            return
        }
        pageViewController.setViewControllers([pages[sender.tag]], direction: .reverse, animated: true)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0) {
            self.view.removeConstraint(self.leadingConstraint)
            let leadingConstraint = self.underLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sender.frame.origin.x)
            self.leadingConstraint = leadingConstraint
            leadingConstraint.isActive = true
            self.view.layoutIfNeeded()
            self.selectedButtonTag = sender.tag
        }
        
    }
}

//MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate

extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else { return nil }
        print(index)
        let previousIndex = index - 1
        
        guard previousIndex < 0 else {
            return pages[previousIndex]
        }
        return nil
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        
        guard let index = pages.firstIndex(of: viewController) else { return nil }
        
        print(index)
        let nextIndex = index + 1
        if nextIndex == pages.count {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard completed else { return }
        
        guard let currentViewController = pageViewController.viewControllers?.first else { return }
        guard let index = pages.firstIndex(of: currentViewController) else { return }
        
        guard let sender = buttons[index] else { return }
        
        guard selectedButtonTag > sender.tag else {
            pageViewController.setViewControllers([pages[sender.tag]], direction: .forward, animated: true)
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0) {
                self.view.removeConstraint(self.leadingConstraint)
                let leadingConstraint = self.underLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sender.frame.origin.x)
                self.leadingConstraint = leadingConstraint
                leadingConstraint.isActive = true
                self.view.layoutIfNeeded()
                
                self.selectedButtonTag = sender.tag
            }
            return
        }
        pageViewController.setViewControllers([pages[sender.tag]], direction: .reverse, animated: true)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0) {
            self.view.removeConstraint(self.leadingConstraint)
            let leadingConstraint = self.underLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sender.frame.origin.x)
            self.leadingConstraint = leadingConstraint
            leadingConstraint.isActive = true
            self.view.layoutIfNeeded()
            self.selectedButtonTag = sender.tag
        }
    }
}

