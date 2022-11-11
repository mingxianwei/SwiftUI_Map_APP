//
//  LocationsView.swift
//  SwiftMapApp
//
//  Created by 明先伟 on 2022/11/11.
//

import SwiftUI
import MapKit



//MARK: - === View ===
struct LocationsView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    //MARK: - === Body ===
    var body: some View {
        
        ZStack{
            Map(coordinateRegion: $viewModel.mapRegion)
                .animation(.easeInOut, value: viewModel.mapLocation)
                .ignoresSafeArea()
            
            VStack {
                headerView
                    .padding()
                
                Spacer()
                
                ZStack {
                    ForEach(viewModel.locations) { location in
                        if location == viewModel.mapLocation {
                            LocationDescView()
                                .shadow(color: Color.black.opacity(0.3),radius: 20)
                                .padding()
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

                        }
                    }
                }
            }
        }

    }
}


//MARK: - === Extention ===

extension LocationsView {
    private var headerView: some View {
        VStack {
            Text(viewModel.mapLocation.name + "," + viewModel.mapLocation.cityName)
                .font(.title)
                .fontWeight(.bold)
            .foregroundColor(.primary)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .animation(.easeInOut, value: viewModel.mapLocation)
            .overlay(alignment: .leading) {
                Image(systemName: "arrow.down")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding()
                    .rotationEffect(Angle(degrees: viewModel.showLocationListView ? 180 : 0  ))
                    .animation(.easeInOut, value: viewModel.showLocationListView)
            }
            .onTapGesture {
                viewModel.toggleShowLocationListView()
            }
            
            if viewModel.showLocationListView {
                LocationsListView()
                    .animation(.easeInOut, value: viewModel.showLocationListView)
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
    }
    
    
}



//MARK: - === Preview ===

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
