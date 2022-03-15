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
    
    private let blurEffect = UIBlurEffect(style: .systemThickMaterial)
    
    private lazy var visualView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeLabel, availabilityView])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = Constants.Dimensions.interItemSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var placeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = model?.address.addressLine
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = Constants.Dimensions.maxContentWidth
        return label
    }()
    
    private lazy var availabilityView: AvailabilityView = {
        let days = self.model?.availability.standardAvailability.day
        let view = AvailabilityView(for: days)
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
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
        centerOffset = CGPoint(x: contentSize.width / 1.5,
                               y: contentSize.height / 1.5)
        let shapeLayer = CAShapeLayer()
        let path = CGMutablePath()
        let pointBezierPath = UIBezierPath()
        pointBezierPath.move(to: CGPoint(x: Constants.Dimensions.pointTableInSet,
                                    y: 0))
        pointBezierPath.addLine(to: CGPoint.zero)
        pointBezierPath.addLine(to: CGPoint(x: Constants.Dimensions.pointTableInSet,
                                       y: Constants.Dimensions.pointTableInSet))
        let box = CGRect(x: Constants.Dimensions.pointTableInSet,
                         y: 0,
                         width: self.frame.size.width - Constants.Dimensions.pointTableInSet,
                         height: self.frame.size.height)
        let roundedRect = UIBezierPath(roundedRect: box,
                                       byRoundingCorners: [.topRight, .bottomLeft, .bottomRight],
                                       cornerRadii: CGSize(width: 5, height: 5))
        path.addPath(roundedRect.cgPath)
        path.addPath(pointBezierPath.cgPath)
        shapeLayer.path = path
        visualView.layer.mask = shapeLayer
    }
    
    override var intrinsicContentSize: CGSize {
        var size = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let sizeContent = Constants.Dimensions.sizeContent
        size.width += sizeContent.left + sizeContent.right
        size.height += sizeContent.top + sizeContent.bottom
        return size
    }
    
    private func setuoVCs() {
        backgroundColor = UIColor.white
        addSubview(visualView)
        addSubview(stackView)
        addSubview(placeLabel)
        addSubview(availabilityView)
        visualView.contentView.addSubview(stackView)
        visualView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(visualView)
        }
    }
}
