//
//  MapAppApp.swift
//  MapApp
//
//  Created by Sakshi Shrivastava on 3/11/26.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var locationViewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LocationsView()
                    .environmentObject(locationViewModel)
            }
        }
    }
}
