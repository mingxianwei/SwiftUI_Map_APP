//
//  Location.swift
//  SwiftMapApp
//
//  Created by 明先伟 on 2022/11/11.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    
    

    let  name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames:[String]
    let link: String
    
    //Identifiable
    var id: String { name + cityName }
    
    //Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
