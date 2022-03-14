//
//  MapView.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import UIKit
import MapKit
import SnapKit

final class MapAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var title: String?
    var subtitle: String?
}

class MapAnnotationView: MKAnnotationView {
    var model: ATM?
    
    private let boxInset = CGFloat(10)
    private let interItemSpacing = CGFloat(10)
    private let maxContentWidth = CGFloat(300)
    private let contentInsets = UIEdgeInsets(top: 10,
                                             left: 30,
                                             bottom: 20,
                                             right: 20)
    private let blurEffect = UIBlurEffect(style: .systemThickMaterial)
    
    private lazy var backgroundMaterial: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeLabel, availabilityView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = interItemSpacing
        addSubview(stackView)
        return stackView
    }()
    
    private lazy var placeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.preferredMaxLayoutWidth = maxContentWidth
        label.text = model?.address.addressLine
        addSubview(label)
        return label
    }()
    
    private lazy var availabilityView: AvailabilityView = {
        let days = self.model?.availability.standardAvailability.day
        let view = AvailabilityView(for: days)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        addSubview(view)
        return view
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
        let contentSize = intrinsicContentSize
        frame.size = intrinsicContentSize
        centerOffset = CGPoint(x: contentSize.width / 2,
                               y: contentSize.height / 2)
        let shape = CAShapeLayer()
        let path = CGMutablePath()
        let pointShape = UIBezierPath()
        pointShape.move(to: CGPoint(x: boxInset,
                                    y: 0))
        pointShape.addLine(to: CGPoint.zero)
        pointShape.addLine(to: CGPoint(x: boxInset,
                                       y: boxInset))
        path.addPath(pointShape.cgPath)
        let box = CGRect(x: boxInset, y: 0, width: self.frame.size.width - boxInset, height: self.frame.size.height)
        let roundedRect = UIBezierPath(roundedRect: box,
                                       byRoundingCorners: [.topRight, .bottomLeft, .bottomRight],
                                       cornerRadii: CGSize(width: 5, height: 5))
        path.addPath(roundedRect.cgPath)
        
        shape.path = path
        backgroundMaterial.layer.mask = shape
    }
    
    override var intrinsicContentSize: CGSize {
        var size = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width += contentInsets.left + contentInsets.right
        size.height += contentInsets.top + contentInsets.bottom
        return size
    }
    
    private func configure() {
        backgroundColor = UIColor.clear
        addSubview(backgroundMaterial)
        backgroundMaterial.contentView.addSubview(stackView)
        activateConstraints()
        
    }
    
    private func activateConstraints() {
        backgroundMaterial.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundMaterial)
        }
    }
}
