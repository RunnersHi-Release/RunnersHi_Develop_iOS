//
//  MainNC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/07/07.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFullWidthBackGesture()
    }
    
    private lazy var fullWidthBackGestureRecognizer = UIPanGestureRecognizer()

        private func setupFullWidthBackGesture() {
            guard
                let interactivePopGestureRecognizer = interactivePopGestureRecognizer,
                let targets = interactivePopGestureRecognizer.value(forKey: "targets")
            else {
                return
            }
            fullWidthBackGestureRecognizer.setValue(targets, forKey: "targets")
            fullWidthBackGestureRecognizer.delegate = self
            view.addGestureRecognizer(fullWidthBackGestureRecognizer)
        }
}


extension MainNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isSystemSwipeToBackEnabled = interactivePopGestureRecognizer?.isEnabled == true
        let isThereStackedViewControllers = viewControllers.count > 1
        return isSystemSwipeToBackEnabled && isThereStackedViewControllers
    }
}
