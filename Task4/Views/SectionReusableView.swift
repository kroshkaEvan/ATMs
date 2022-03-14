//
//  SectionReusableView.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import SnapKit
import UIKit

final class SectionReusableView: UICollectionReusableView {

    static let reuseId = "Section"

     lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.textColor = .white
         label.font = Constants.Fonts.headerFont
        self.addSubview(label)
        return label
    }()

    private let padding = Constants.Dimensions.defaultPadding
    private let cornerRadius: CGFloat = Constants.Dimensions.cornerRadius

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configure() {
        self.backgroundColor = .white.withAlphaComponent(0.1)
        self.layer.cornerRadius = cornerRadius
        activateConstraints()
    }

    private func activateConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(padding)
            make.bottom.equalTo(self.snp.bottom).offset(-padding)
            make.leading.equalTo(self.snp.leading).offset(padding)

        }
    }
}
