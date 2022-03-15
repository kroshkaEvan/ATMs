//
//  SectionReusableView.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import SnapKit
import UIKit

final class SectionReusableView: UICollectionReusableView {

    static let identifier = "Section"

     lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.textColor = .white
        label.font = Constants.Fonts.headerFont
        return label
    }()

    private let padding = Constants.Dimensions.defaultPadding
    private let cornerRadius: CGFloat = Constants.Dimensions.defaultCornerRadius

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configure() {
        self.addSubview(sectionLabel)
        self.backgroundColor = .white.withAlphaComponent(0.1)
        self.layer.cornerRadius = cornerRadius
        activateConstraints()
    }

    private func activateConstraints() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(padding)
            make.bottom.equalTo(self.snp.bottom).offset(-padding)
            make.leading.equalTo(self.snp.leading).offset(padding)

        }
    }
}
