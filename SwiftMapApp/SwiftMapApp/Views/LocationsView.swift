//
//  LocationsView.swift
//  SwiftMapApp
//
//  Created by ζεδΌ on 2022/11/11.
//

import SwiftUI
import MapKit



//MARK: - === View ===
struct LocationsView: View {
    
    let maxWidthForIpad: CGFloat = 700
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    @State private var  showLocationList: Bool = false
    @State private var  mapLocation:Location = LocationsDataService.locations.first!
    @State private var  mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    
    
    
    //MARK: - === Body ===
    var body: some View {
        
        ZStack{
            mapLayer
            VStack {
                headerView
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                bottomLayer
            }
        }
        .sync($viewModel.showLocationListView, binding: $showLocationList)
        .sync($viewModel.mapLocation, binding: $mapLocation)
        .sync($viewModel.mapRegion, binding: $mapRegion)
        .onAppear(){
            mapRegion = viewModel.mapRegion
        }
        .sheet(item: $viewModel.sheetLocation, onDismiss: nil) {
            LocationDetailView(location: $0)
        }
    }
}


//MARK: - === Extention ===

extension LocationsView {
    
    private var headerView: some View {
        VStack {
            Text(mapLocation.name + "," + mapLocation.cityName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down")
                        .font(.title)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: showLocationList ? 180 : 0  ))
                        .animation(.easeInOut, value: showLocationList)
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        showLocationList.toggle()
                    }
                }
            
            if showLocationList {
                LocationsListView()
                    .animation(.easeInOut, value: showLocationList)
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
    }
    
    
    private var mapLayer:some View {
        Map(coordinateRegion: $mapRegion, annotationItems: viewModel.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(location == mapLocation ? 1: 0.6)
                    .onTapGesture {
                        viewModel.showNextLocation(location: location)
                    }
            }
        })
        .ignoresSafeArea()
        .animation(.easeInOut, value: viewModel.mapLocation)
    }
    
    private var bottomLayer: some View {
        ZStack {
            ForEach(viewModel.locations) { location in
                if location == viewModel.mapLocation {
                    LocationDescView(location: location)
                        .shadow(color: Color.black.opacity(0.3),radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    
                }
            }
        }
    }
    
}


/// θ§£ε³ Publishηθ’«η»ε?ε°θ§εΎζ΄ζ°δΉεηι?ι’
extension View {
    
    func sync<T:Equatable>(_ published:Binding<T>,binding:Binding<T>) -> some View {
        self
            .onChange(of: published.wrappedValue) { newValue in
                withAnimation(.easeInOut) {
                    binding.wrappedValue = newValue
                }
            }
        
            .onChange(of: binding.wrappedValue) { newValue in
                published.wrappedValue = newValue
            }
    }
    
}


//MARK: - === Preview ===

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
