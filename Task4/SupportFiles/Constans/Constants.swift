//
//  Constants.swift
//  Task4
//
//  Created by Эван Крошкин on 14.03.22.
//

import UIKit

class Constants {
    class Fonts {
        static let defaultFontSize: CGFloat = 14
        static let headerFontSize: CGFloat = 16
        static let cellSubviewsFont = UIFont.systemFont(ofSize: defaultFontSize, weight: .light)
        static let headerFont = UIFont.systemFont(ofSize: headerFontSize, weight: .light)
    }
    
    class Colors {
        static let appMainColor = UIColor(red: 58 / 255,
                                          green: 124 / 255,
                                          blue: 80 / 255,
                                          alpha: 1)
    }

    class Dimensions {
        static let cellsSpacing: CGFloat = 10
        static let defaultPadding: CGFloat = 5
        static let defaultCornerRadius: CGFloat = 7
        static let sectionHeight: CGFloat = 30
        static let pointTableInSet = CGFloat(10)
        static let interItemSpacing = CGFloat(10)
        static let maxContentWidth = CGFloat(300)
        static let sizeContent = UIEdgeInsets(top: 10,
                                                left: 30,
                                                bottom: 20,
                                                right: 20)
    }
    
    class Location {
        static let distance: Double = 200
    }
}
