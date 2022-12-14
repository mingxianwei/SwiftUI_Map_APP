//
//  SwiftMapAppApp.swift
//  SwiftMapApp
//
//  Created by ζεδΌ on 2022/11/11.
//

import SwiftUI

@main
struct SwiftMapApp: App {
    
    @StateObject private var viewModel: LocationsViewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
           LocationsView()
                .environmentObject(viewModel)
        }
    }
}
