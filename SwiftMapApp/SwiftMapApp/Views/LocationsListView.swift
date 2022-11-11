//
//  LocationsListView.swift
//  SwiftMapApp
//
//  Created by 明先伟 on 2022/11/11.
//

import SwiftUI

//MARK: - === View ===
struct LocationsListView: View {
    
    @EnvironmentObject var viewModel: LocationsViewModel
    
    //MARK: - === Body ===
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                Button {
                    viewModel.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                          .listRowBackground(Color.clear)
                }

            }
        }.listStyle(.plain)
    }
}

//MARK: - === Extension ===
extension LocationsListView {
    
    private func listRowView(location:Location) -> some View {
        HStack(spacing: 10) {
            Image(location.imageNames.first!)
                .resizable()
                .frame(width: 50,height: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading,spacing: 4) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)

            }
            .frame(maxWidth:.infinity,alignment: .leading)
        }
    }
    
}


//MARK: - === Preview ===
struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}

