//
//  LocationsViewModel.swift
//  SwiftMapApp
//
//  Created by 明先伟 on 2022/11/11.
//

import Foundation
import MapKit
import SwiftUI


class LocationsViewModel: ObservableObject {
    /// 所有位置数组
    @Published var locations: [Location]
    
    ///地图视图显示的Location
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // 地图视图显示的经纬度
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
   
    //地图视图是否显示locationListView
    @Published var showLocationListView:Bool = false
    
    init() {
        
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: self.mapLocation)
    }
    
    private func updateMapRegion(location:Location) {
    
        withAnimation(.easeInOut) {
            self.mapRegion = MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
    }
    
    
    func showNextLocation(location:Location)  {
        withAnimation(.easeInOut) {
            self.mapLocation = location
            self.showLocationListView = false
        }

    }
    
    // 切换到下一个 Location
    func switchToNextLocation() {
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Error.Can Not Find Current Location in locationArray,Should Never Happen ")
            return
        }
        
        if locations.count > 0 {
            let nextIndex = ( currentIndex + 1 ) % locations.count
            let location = locations[nextIndex]
            
            showNextLocation(location: location)
            
        } else {
            print("ERROR")
        }
    }
}


//
extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        if lhs.center.latitude == rhs.center.latitude &&
            lhs.center.longitude == rhs.center.longitude &&
            lhs.span.latitudeDelta == rhs.span.latitudeDelta &&
            lhs.span.longitudeDelta == rhs.span.longitudeDelta {
            return true
        } else {
            return false
        }
    }
}
