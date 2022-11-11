//
//  LocationsViewModel.swift
//  SwiftMapApp
//
//  Created by 明先伟 on 2022/11/11.
//

import Foundation
import MapKit

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
        self .updateMapRegion(location: self.mapLocation)
    }
    
    private func updateMapRegion(location:Location) {
        self.mapRegion = MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }
    
    
    func showNetLocation(location:Location)  {
        mapLocation = location
        showLocationListView.toggle()
    }
}
