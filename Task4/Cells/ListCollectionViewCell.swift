//
//  ListCollectionViewCell.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import UIKit
import SnapKit

class ListCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ListCell"
    var model: ATM?
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.numberOfLines = 4
        label.font = Constants.Fonts.addressFont
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var availabilityButton: UIButton = {
        var button = UIButton()
        button.setTitle(Constants.Strings.availabilityButtonTitle,
                        for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.backgroundColor = Constants.Colors.appMainColor
        button.layer.shadowOpacity = 0.95
        button.layer.shadowRadius = 30
        button.layer.shadowColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.defaultHigh,
                                         for: .vertical)
        button.setContentCompressionResistancePriority(.required,
                                                       for: .vertical)
        return button
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.cellSubviewsFont
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh,
                                        for: .vertical)
        label.setContentCompressionResistancePriority(.required,
                                                      for: .vertical)
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .fill
        stack.distribution = .fill
        stack.contentScaleFactor = .greatestFiniteMagnitude
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    
    func setup(viewModel: ATM?) {
        guard let atmModel = viewModel else { return }
        addressLabel.text = atmModel.address.addressLine
        currencyLabel.text = "\(Constants.Strings.currency) \(atmModel.currency.rawValue)"
        self.model = viewModel
    }
    
    func activateConstraints() {
        addSubview(contentStackView)
        availabilityButton.addTarget(self,
                                     action: #selector(didTapButton),
                                     for: .touchUpInside)
        [addressLabel, currencyLabel, availabilityButton].forEach { contentStackView.addArrangedSubview($0) }
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = Constants.Dimensions.defaultCornerRadius
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Dimensions.defaultPadding)
            make.leading.equalToSuperview().offset(Constants.Dimensions.defaultPadding)
            make.trailing.equalToSuperview().offset(-Constants.Dimensions.defaultPadding)
            make.bottom.equalToSuperview().offset(-Constants.Dimensions.defaultPadding)
        }
    }
    
    @objc private func didTapButton() {
        guard let model = model else { return }
        let availabilityView = AvailabilityView(for: model.availability.standardAvailability.day)
        availabilityView.frame = self.bounds
        availabilityView.center = self.center
        self.superview?.addSubview(availabilityView)
        availabilityView.alpha = 0
        availabilityButton.loadingAnimation()
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .transitionFlipFromLeft,
                       animations: {
            availabilityView.alpha = 1
        }, completion: nil)
    }
}

