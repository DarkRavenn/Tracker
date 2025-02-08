//
//  OnboardingViewController.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 08.02.2025.
//

import UIKit

final class OnboardingPageViewController: UIPageViewController {
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var onboardingPages: [UIViewController] = {
        let page1 = OnboardingPageFactory.createOnboardingPage(
            bodyText: Resources.Strings.Onboarding.BodyText.pageOne,
            image: Resources.Images.Onboarding.pageOne,
            buttonText: Resources.Strings.Onboarding.ButtonText.pageOneOfPageTwo
            ) { [weak self] in
                self?.closeOnboarding()
            }
        
        let page2 = OnboardingPageFactory.createOnboardingPage(
            bodyText: Resources.Strings.Onboarding.BodyText.pageTwo,
            image: Resources.Images.Onboarding.pageTwo,
            buttonText: Resources.Strings.Onboarding.ButtonText.pageOneOfPageTwo
            )  { [weak self] in
                self?.closeOnboarding()
            }
        
        return [page1, page2]
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingPages.count
        pageControl.currentPage = 0
        
        pageControl.currentPageIndicatorTintColor = .ypBlack.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        pageControl.pageIndicatorTintColor = .ypBlack.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light)).withAlphaComponent(0.3)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаем OnboardingViewController собственным DataSource
        dataSource = self
        
        // Устанавливаем OnboardingViewController собственным делегатом
        delegate = self
        
        if let first = onboardingPages.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -134),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func goToNextPage() {
        if let currentVC = viewControllers?.first,
           let currentIndex = onboardingPages.firstIndex(of: currentVC),
           currentIndex + 1 < onboardingPages.count {
            let nextVC = onboardingPages[currentIndex + 1]
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    private func closeOnboarding() {
        // Закрытие  или завершение onboarding
        print("Просмотр онборинга завершен")
        userDefaults.set(true, forKey: Resources.Strings.UserDefaults.isOnboardingViewed)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //возвращаем предыдущий (относительно переданного viewController) дочерний контроллер
        guard let viewControllerIndex = onboardingPages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return onboardingPages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //возвращаем следующий (относительно переданного viewController) дочерний контроллер
        guard let viewControllerIndex = onboardingPages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < onboardingPages.count else {
            return nil
        }
        
        return onboardingPages[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = onboardingPages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}
