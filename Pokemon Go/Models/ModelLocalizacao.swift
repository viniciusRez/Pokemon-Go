//
//  ModelLocalizacao.swift
//  TrabalhandoMapas
//
//  Created by Vinicius Rezende on 29/12/22.
//

import Foundation
import MapKit
struct Localizacao {
    var latitude:CLLocationDegrees
    var longitude:CLLocationDegrees
    var deltalatitude:CLLocationDegrees
    var deltalongitude:CLLocationDegrees
    var localizacao: CLLocationCoordinate2D
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
        self.deltalatitude = 0.01
        self.deltalongitude = 0.01
        self.localizacao = CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }
}
