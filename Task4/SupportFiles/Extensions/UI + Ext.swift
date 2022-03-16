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

extension UIButton {
    func loadingAnimation() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.9
        pulse.toValue = 1.0
        pulse.duration = 0.3
        layer.add(pulse, forKey: nil)
    }
}

extension UILabel {
    func setupWorkDayLabel(dayText: String) {
        font = Constants.Fonts.cellSubviewsFont
        text = dayText
        textColor = .darkGray
        adjustsFontSizeToFitWidth = true
    }
    
    func setupWeekendLabel(dayText: String) {
        font = Constants.Fonts.cellSubviewsFont
        text = dayText
        textColor = Constants.Colors.appMainColor
        adjustsFontSizeToFitWidth = true
    }
}

extension UIStackView {
    func setupCustomStackView() {
        alignment = .fill
        axis = .vertical
        spacing = 2
        distribution = .fillEqually
        setContentHuggingPriority(.defaultHigh,
                                        for: .vertical)
        setContentHuggingPriority(.defaultHigh,
                                        for: .horizontal)
    }
}
