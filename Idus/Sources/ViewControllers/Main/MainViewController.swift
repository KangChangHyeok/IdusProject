//
//  MainViewController.swift
//  Idus
//
//  Created by 강창혁 on 2023/11/03.
//

import UIKit

final class MainViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoImageView, searchView, cartButton])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "homeLogo")
        return imageView
    }()
    
    private lazy var searchView: SearchView = SearchView()
    
    private lazy var cartButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.image = .init(systemName: "cart")
        buttonConfiguration.baseForegroundColor = .black
        let button = UIButton(configuration: buttonConfiguration)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todayButton, foodButton, newButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var todayButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.title = "홈"
        buttonConfiguration.titleAlignment = .center
        buttonConfiguration.baseForegroundColor = .black
        let button = UIButton(configuration: buttonConfiguration)
        button.tag = 0
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var foodButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.title = "수제먹거리"
        buttonConfiguration.titleAlignment = .center
        buttonConfiguration.baseForegroundColor = .lightGray
        let button = UIButton(configuration: buttonConfiguration)
        button.tag = 1
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var newButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.title = "NEW"
        buttonConfiguration.titleAlignment = .center
        buttonConfiguration.baseForegroundColor = .lightGray
        let button = UIButton(configuration: buttonConfiguration)
        button.tag = 2
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let pageView: UIView = {
        let view = UIView()
        return view
    }()
    
    weak var leadingConstraint: NSLayoutConstraint!
    
    private var selectedButtonTag = 0
    private var pageViewController = MainPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private var pages = [UIViewController]() 
    private lazy var buttons = [todayButton, foodButton, newButton]
    private var animator: UIViewPropertyAnimator?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureDefaults() {
        view.backgroundColor = .white
        configurePageViewController()
        print(buttons.count)
    }
    
    override func configureUI() {
        configureSearchStackViewLayout()
        configureButtonStackViewLayout()
        configureUnderLineViewLayout()
        configurePageVIewLayout()
    }
    
    func configurePageViewController() {
        self.addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let homeViewController = HomeViewController()
        let foodViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(withIdentifier: "FoodViewController" ) as! FoodViewController
        let newViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(withIdentifier: "NewViewController" ) as! NewViewController
        
        [homeViewController, foodViewController, newViewController].forEach { viewController in
            pages.append(viewController)
        }
        
        pageViewController.setViewControllers([homeViewController], direction: .forward, animated: false)
    }
}

// MARK: - Layout

private extension MainViewController {
    
    func configureSearchStackViewLayout() {
        view.addSubview(searchStackView)
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        searchView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchStackView.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    func configureButtonStackViewLayout() {
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureUnderLineViewLayout() {
        self.leadingConstraint = underLine.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor)
        
        view.addSubview(underLine)
        underLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingConstraint,
            underLine.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            underLine.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            underLine.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func configurePageVIewLayout() {
        view.addSubview(pageView)
        view.addSubview(pageViewController.view)
        
        pageView.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: pageView.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: pageView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: pageView.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: pageView.bottomAnchor)
        ])
    }
}

// MARK: - @objc Methods

private extension MainViewController {
    
    @objc func buttonDidTap(sender: UIButton) {
        guard selectedButtonTag > sender.tag else {
            presentedPreviousPage(sender: sender)
            return
        }
        presentedNextPage(sender: sender)
    }
    
    /// 이전 페이지로 돌아갈때
    func presentedPreviousPage(sender: UIButton) {
        configureButtonWhenPresentedPage(sender: sender)
        pageViewController.setViewControllers([pages[sender.tag]], direction: .forward, animated: true)
        updateSelectedButtonLeadingConstraint(sender: sender)
    }
    
    /// 다음 페이지로 넘어갈때
    func presentedNextPage(sender: UIButton) {
        configureButtonWhenPresentedPage(sender: sender)
        pageViewController.setViewControllers([pages[sender.tag]], direction: .reverse, animated: true)
        updateSelectedButtonLeadingConstraint(sender: sender)
    }
    
    func configureButtonWhenPresentedPage(sender: UIButton) {
        buttons.forEach { $0.configuration?.baseForegroundColor = .lightGray }
        sender.configuration?.baseForegroundColor = .black
    }
    
    func updateSelectedButtonLeadingConstraint(sender: UIButton) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0) {
            self.view.removeConstraint(self.leadingConstraint)
            let leadingConstraint = self.underLine.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: sender.frame.origin.x
            )
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
        let sender = buttons[index]
        
        guard selectedButtonTag > sender.tag else {
            presentedPreviousPage(sender: sender)
            return
        }
        presentedNextPage(sender: sender)
    }
}

