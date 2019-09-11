//
//  OnboardingViewController.swift
//
//  Created by Agaba Nkuuhe
//  Copyright © 2019 Clearbridge Mobile. All rights reserved.

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - Properties
    private var dataSource = OnboardingDataSource()
    var pageController: UIPageViewController!

    // MARK: - Outlets & Actions
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!

    @IBAction func nextScreen(_ sender: UIButton) {
        guard let current = pageController.viewControllers?.first,
            let next = pageController.dataSource?.pageViewController(pageController, viewControllerAfter: current)
            else { return }

        pageController.setViewControllers([next], direction: .forward, animated: true)
        pageController.pageControl?.currentPage = pageControl.currentPage
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageController()
        pageControl.numberOfPages = dataSource.numberOfItems
    }

    fileprivate func setupPageController() {
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageController.view.frame = pageView.bounds
        pageController.dataSource = dataSource
        pageController.delegate = self

        if let first = dataSource.orderedViewControllers.first {
            pageController.setViewControllers([first], direction: .forward, animated: true)
        }

        addChild(pageController)
        pageView.addSubview(pageController.view)
        pageController.didMove(toParent: self)
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageControl.currentPage = pageViewController.pageControl?.currentPage ?? 0
    }
}

private extension UIPageViewController {
    var pageControl: UIPageControl? {
        for view in view.subviews where view is UIPageControl {
            return (view as! UIPageControl)
        }
        return nil
    }
}
