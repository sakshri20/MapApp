//
//  LocationsView.swift
//  MapApp
//
//  Created by Sakshi Shrivastava on 3/11/26.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject var viewModel: LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(position: $viewModel.mapCameraPosition)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()
                
                ZStack {
                    ForEach(viewModel.locations, content: { location in
                        if viewModel.mapLocation == location {
                            LocationPreviewView(location: location)
                                .shadow(
                                    color: .black.opacity(0.3),
                                    radius: 20)
                                .padding()
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)))
                        }
                    })
                }
            }
        }
    }
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Button(action: {
                viewModel.toggleLocationsList()
            }, label: {
                Text(viewModel.mapLocation.name + "," +
                     viewModel.mapLocation.cityName)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .animation(.none, value: viewModel.mapLocation)
                .overlay(alignment: .leading, content: {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                })
            })
            
            if viewModel.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3),radius: 20, x: 0, y: 15)
    }
}

#Preview {
    NavigationStack {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
    
}
