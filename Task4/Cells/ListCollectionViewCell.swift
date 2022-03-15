//
//  ListCollectionViewCell.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import UIKit
import SnapKit

final class ListCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "ListCell"
    var model: ATM?

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.numberOfLines = 4
        label.font = Constants.Fonts.cellSubviewsFont
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var availabilityButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle(Constants.Strings.availabilityButtonTitle, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tintColor = Constants.Colors.appMainColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.setContentCompressionResistancePriority(.required, for: .vertical)
        button.addTarget(self, action: #selector(didPressAvailabilityButton), for: .touchUpInside)
        return button
    }()

    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Currency"
        label.font = Constants.Fonts.cellSubviewsFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
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
        self.addSubview(stack)
        [addressLabel, availabilityButton, currencyLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()

    private let padding = Constants.Dimensions.defaultPadding
    private let cornerRadius: CGFloat = Constants.Dimensions.defaultCornerRadius

    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }

    func configure() {
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
        activateConstraints()

        guard let atm = model else { return }
        addressLabel.text = atm.address.addressLine
        currencyLabel.text = atm.currency.rawValue
    }

    private func activateConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.bottom.equalToSuperview().offset(-padding)
        }
    }

    @objc private func didPressAvailabilityButton() {
        guard let model = model else { return }
        let availabilityView = AvailabilityView(for: model.availability.standardAvailability.day)
        availabilityView.frame = self.bounds
        availabilityView.center = self.center
        self.superview?.addSubview(availabilityView)
        availabilityView.alpha = 0

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .transitionCrossDissolve,
                       animations: {
            availabilityView.alpha = 1
        }, completion: nil)
    }
}

