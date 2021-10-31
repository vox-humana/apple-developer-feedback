//
//  Model.swift
//  MKMapSnapshotterDemo
//
//  Created by Arthur on 29/09/2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import Foundation
import MapKit

struct Point : Decodable {
    let lat: Double
    let lon: Double
}

extension Point {
    static func content(of url: URL) throws -> Point {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Point.self, from: data)
    }
}

extension Point {
    func region() -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
    }
}
