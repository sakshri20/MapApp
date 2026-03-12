//
//  LocationsListView.swift
//  MapApp
//
//  Created by Sakshi Shrivastava on 3/11/26.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var locationsViewModel: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(locationsViewModel.locations, content: { location in
                Button(action: {
                    locationsViewModel.showNextLocation(location: location)
                }, label: {
                    listRowView(location: location)
                        .padding(.vertical, 4)
                        .listRowBackground(Color.clear)
                })
            })
        }
        .listStyle(.plain)
    }
}

extension LocationsListView {
    
    func listRowView(location: Location) -> some View {
        return HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    NavigationStack {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
    
}
