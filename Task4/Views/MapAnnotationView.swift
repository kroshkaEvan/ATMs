//
//  MapView.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import UIKit
import MapKit
import SnapKit

class MapAnnotationView: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var title: String?
    var subtitle: String?
}
