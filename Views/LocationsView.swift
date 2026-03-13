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
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $viewModel.sheetLocation, onDismiss: nil, content: { location in
            LocationDetailView(location: location)
        })
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
    
    private var mapLayer: some View {
        Map(position: $viewModel.mapCameraPosition){
            ForEach(viewModel.locations) { location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            viewModel.showNextLocation(location: location)
                        }
                }
            }
        }
    }
    
    private var locationsPreviewStack: some View {
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

#Preview {
    NavigationStack {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
    
}
