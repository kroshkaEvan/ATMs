//
//  SectionReusableView.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import SnapKit
import UIKit

class SectionReusableView: UICollectionReusableView {
    static let identifier = Constants.Strings.section
    
    lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Strings.section
        label.textColor = .white
        label.font = Constants.Fonts.sectionFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        self.addSubview(sectionLabel)
        self.backgroundColor = Constants.Colors.appMainColor
        self.layer.cornerRadius = Constants.Dimensions.defaultCornerRadius
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(Constants.Dimensions.defaultPadding)
            make.bottom.equalTo(self.snp.bottom).offset(-Constants.Dimensions.defaultPadding)
            make.center.equalTo(self.snp.center).offset(Constants.Dimensions.defaultPadding)
        }
    }
}
