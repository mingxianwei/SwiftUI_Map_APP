//
//  LocationDetailView.swift
//  SwiftMapApp
//
//  Created by 明先伟 on 2022/11/12.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    let location:Location
    
    @EnvironmentObject var viewModel:LocationsViewModel
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                
                titleSection
                
                Divider()
                
                describeSection
                
                mapLayer
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment:.topLeading) {
            Button {
                viewModel.sheetLocation = nil
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .padding(16)
                    .foregroundColor(.primary)
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding()
            }

        }
    }
    
    
     private var imageSection: some View {
        TabView {
            ForEach(location.imageNames,id: \.self){
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading,spacing: 10){
            
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
        
    }
    
    private var describeSection: some View {
        VStack(alignment: .leading,spacing: 10){
            
            Text(location.description)
                .font(.title3)
                .foregroundColor(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read More On Wikipedia", destination: url)
                    .font(.title3)
                    .foregroundColor(.blue)
                
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
        
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems:[location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(15)
    }
    
    
}


struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
