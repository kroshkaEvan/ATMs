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
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1.0
        animation.duration = 0.2
        layer.add(animation, forKey: nil)
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

extension UIView {
    var width: CGFloat{
        return self.frame.size.width
    }
    
    var height: CGFloat{
        return self.frame.size.height
    }
    
    var top: CGFloat{
        return self.frame.origin.y
    }
    
    var bottom: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    
    var left: CGFloat{
        return self.frame.origin.x
    }
    
    var right: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
}
