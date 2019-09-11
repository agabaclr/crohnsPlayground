//
//  OnboardingDataSource.swift
//  chrons_playground
//
//  Created by Agaba Nkuuhe on 2019-09-11.
//  Copyright © 2019 Crohn's and Colitis Canada. All rights reserved.
//

import UIKit

class OnboardingDataSource: NSObject, UIPageViewControllerDataSource {

    var numberOfItems: Int {
        return orderedViewControllers.count
    }
    public private(set) lazy var orderedViewControllers: [UIViewController] = {
        return []
    }()

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.firstIndex(of: viewController) else { return nil }

        let previousIndex = index - 1

        guard previousIndex >= 0, orderedViewControllers.count > previousIndex else { return nil }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.firstIndex(of: viewController) else { return nil }

        let nextIndex = index + 1

        guard nextIndex < orderedViewControllers.count else { return nil }

        return orderedViewControllers[nextIndex]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return numberOfItems
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = orderedViewControllers.first,
            let index = orderedViewControllers.firstIndex(of: first) else {
                return 0
        }
        return index
    }
}

