//
//  AvailabilityView.swift
//  Task4
//
//  Created by Эван Крошкин on 14.03.22.
//

import UIKit
import SnapKit

final class AvailabilityView: UIView {
    var model: [Day]?

    private lazy var mondayPermanentLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.monday.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var tuesdayPermanentLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.tuesday.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var wednesdayPermanentLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.wednesday.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var thursdayPermanentLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.thursday.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var fridayPermanentLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.friday.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var saturdayPermanentLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.saturday.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .red
        return label
    }()
    
    private lazy var sundayPermanentLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.sunday.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .red
        return label
    }()

    private lazy var mondayDynamicLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.weekend.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var tuesdayDynamicLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.weekend.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var wednesdayDynamicLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.weekend.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var thursdayDynamicLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.weekend.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var fridayDynamicLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.weekend.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var saturdayDynamicLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.weekend.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var sundayDynamicLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.text = Constants.Days.weekend.shortValue
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()

    private lazy var permanentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.setContentHuggingPriority(.defaultHigh,
                                        for: .vertical)
        stack.setContentHuggingPriority(.defaultHigh,
                                        for: .horizontal)
        [mondayPermanentLabel,
         tuesdayPermanentLabel,
         wednesdayPermanentLabel,
         thursdayPermanentLabel,
         fridayPermanentLabel,
         saturdayPermanentLabel,
         sundayPermanentLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()

    private lazy var dynamicStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.setContentHuggingPriority(.defaultLow,
                                        for: .vertical)
        stack.setContentHuggingPriority(.defaultLow,
                                        for: .horizontal)
        [mondayDynamicLabel,
         tuesdayDynamicLabel,
         wednesdayDynamicLabel,
         thursdayDynamicLabel,
         fridayDynamicLabel,
         saturdayDynamicLabel,
         sundayDynamicLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()

    private lazy var mainStackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        stack.distribution = .equalCentering
        [permanentStackView, dynamicStackView].forEach { stack.addArrangedSubview($0) }
        addSubview(stack)
        return stack
    }()

    private let padding = Constants.Dimensions.defaultPadding

    init(for days: [Day]?) {
        self.model = days
        super.init(frame: .zero)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configure() {
        backgroundColor = Constants.Colors.appMainColor.withAlphaComponent(0.9)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeView(_:)))
        addGestureRecognizer(gesture)
        configureLabels()
        activateConstraints()
    }

    private func configureLabels() {
        guard let model = model else { return }

        for (dayIndex, day) in model.enumerated() {
            for (labelIndex, label) in dynamicStackView.arrangedSubviews.enumerated() {
                if dayIndex == labelIndex, let dayLabel = (label as? UILabel) {
                    dayLabel.text = day.openingTime.rawValue + "-" + day.closingTime.rawValue
                }
            }
        }
    }

    private func activateConstraints() {
        mainStackview.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(padding)
            make.bottom.equalTo(self.snp.bottom).offset(-padding)
            make.leading.equalTo(self.snp.leading).offset(padding)
            make.trailing.equalTo(self.snp.trailing).offset(-padding)
        }
    }

    @objc private func closeView(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .transitionCrossDissolve,
                       animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}
