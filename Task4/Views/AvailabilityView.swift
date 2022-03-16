//
//  AvailabilityView.swift
//  Task4
//
//  Created by Эван Крошкин on 14.03.22.
//

import UIKit
import SnapKit

class AvailabilityView: UIView {
    var model: [Day]?
    
    private lazy var mondayShortNameLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.monday.shortName)
        return label
    }()
    
    private lazy var tuesdayShortNameLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.thursday.shortName)
        return label
    }()
    
    private lazy var wednesdayShortNameLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.wednesday.shortName)
        return label
    }()
    
    private lazy var thursdayShortNameLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.thursday.shortName)
        return label
    }()
    
    private lazy var fridayShortNameLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.friday.shortName)
        return label
    }()
    
    private lazy var saturdayShortNameLabel: UILabel = {
        let label = UILabel()
        label.setupWeekendLabel(dayText: Constants.Days.saturday.shortName)
        return label
    }()
    
    private lazy var sundayShortNameLabel: UILabel = {
        let label = UILabel()
        label.setupWeekendLabel(dayText: Constants.Days.sunday.shortName)
        return label
    }()
    
    private lazy var mondayDynamicLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.monday.shortName)
        return label
    }()
    
    private lazy var tuesdayDynamicLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.thursday.shortName)
        return label
    }()
    
    private lazy var wednesdayDynamicLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.wednesday.shortName)
        return label
    }()
    
    private lazy var thursdayDynamicLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.thursday.shortName)
        return label
    }()
    
    private lazy var fridayDynamicLabel: UILabel = {
        let label = UILabel()
        label.setupWorkDayLabel(dayText: Constants.Days.friday.shortName)
        return label
    }()
    
    private lazy var saturdayDynamicLabel: UILabel = {
        let label = UILabel()
        label.setupWeekendLabel(dayText: Constants.Days.saturday.shortName)
        return label
    }()
    
    private lazy var sundayDynamicLabel: UILabel = {
        let label = UILabel()
        label.setupWeekendLabel(dayText: Constants.Days.sunday.shortName)
        return label
    }()
    
    private lazy var shortNameStackView: UIStackView = {
        let stack = UIStackView()
        stack.setupCustomStackView()
        return stack
    }()
    
    private lazy var dynamicStackView: UIStackView = {
        let stack = UIStackView()
        stack.setupCustomStackView()
        return stack
    }()
    
    private lazy var mainStackview: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 2
        stack.distribution = .equalCentering
        [shortNameStackView, dynamicStackView].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    init(for days: [Day]?) {
        self.model = days
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        addSubview(mainStackview)
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapClose(_:)))
        addGestureRecognizer(gesture)
        backgroundColor = .white.withAlphaComponent(0.8)
        configureLabels()
        mainStackview.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(Constants.Dimensions.defaultPadding)
            make.bottom.equalTo(self.snp.bottom).offset(-Constants.Dimensions.defaultPadding)
            make.leading.equalTo(self.snp.leading).offset(Constants.Dimensions.defaultPadding)
            make.trailing.equalTo(self.snp.trailing).offset(-Constants.Dimensions.defaultPadding)
        }
    }
    
    @objc private func didTapClose(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .transitionCrossDissolve,
                       animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    private func configureLabels() {
        [mondayShortNameLabel,
         tuesdayShortNameLabel,
         wednesdayShortNameLabel,
         thursdayShortNameLabel,
         fridayShortNameLabel,
         saturdayShortNameLabel,
         sundayShortNameLabel].forEach { shortNameStackView.addArrangedSubview($0) }
        [mondayDynamicLabel,
         tuesdayDynamicLabel,
         wednesdayDynamicLabel,
         thursdayDynamicLabel,
         fridayDynamicLabel,
         saturdayDynamicLabel,
         sundayDynamicLabel].forEach { dynamicStackView.addArrangedSubview($0) }
        
        guard let model = model else { return }
        
        for (dayIndex, day) in model.enumerated() {
            for (labelIndex, label) in dynamicStackView.arrangedSubviews.enumerated() {
                if dayIndex == labelIndex, let dayLabel = (label as? UILabel) {
                    dayLabel.text = day.openingTime.rawValue + "-" + day.closingTime.rawValue
                }
            }
        }
    }
}
