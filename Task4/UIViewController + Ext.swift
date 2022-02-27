//
//  Extension.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import UIKit

extension UIViewController {
    
    func set(view: UIView, _ childVc: UIViewController) {
        addChild(childVc)
        childVc.didMove(toParent: self)
        view.addSubview(childVc.view)
        childVc.view.frame = view.bounds
        childVc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func changeVCs(view: UIView, _ childVc: UIViewController, _ oldVc: UIViewController) {
        self.set(view: view, childVc)
        oldVc.willMove(toParent: nil)
        oldVc.view.removeFromSuperview()
        oldVc.removeFromParent()
    }
}
