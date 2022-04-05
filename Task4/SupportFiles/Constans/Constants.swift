//
//  Constants.swift
//  Task4
//
//  Created by Эван Крошкин on 14.03.22.
//

import UIKit

class Constants {
    class Fonts {
        static let daySize: CGFloat = 15
        static let addressSize: CGFloat = 19
        static let sectionFontSize: CGFloat = 16
        static let sectionFont = UIFont.systemFont(ofSize: sectionFontSize,
                                                   weight: .light)
        static let cellSubviewsFont = UIFont.systemFont(ofSize: daySize,
                                                        weight: .light)
        static let addressFont = UIFont.systemFont(ofSize: addressSize,
                                                   weight: .light)
    }
    
    class Colors {
        static let appMainColor = UIColor(red: 250 / 255,
                                          green: 54 / 255,
                                          blue: 51 / 255,
                                          alpha: 0.6)
    }

    class Dimensions {
        static let cellsSpacing: CGFloat = 5
        static let defaultPadding: CGFloat = 5
        static let defaultCornerRadius: CGFloat = 7
        static let sectionHeight: CGFloat = 30
        static let pointTableInSet = CGFloat(10)
        static let interItemSpacing = CGFloat(10)
        static let maxLayoutWidth = CGFloat(300)
        static let sizeContent = UIEdgeInsets(top: 10,
                                                left: 30,
                                                bottom: 20,
                                                right: 20)
    }
    
    class Location {
        static let distance: Double = 700
    }
}
