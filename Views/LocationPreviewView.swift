//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by Sakshi Shrivastava on 3/12/26.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var locationsViewModel: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
                        
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button(action: {
            locationsViewModel.sheetLocation = location
        }, label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        })
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button(action: {
            locationsViewModel.nextButtonPressed()
        }, label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        })
        .buttonStyle(.bordered)
    }
}

#Preview {
    NavigationStack {
        ZStack {
            Color.green.ignoresSafeArea()
            
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
                .environmentObject(LocationsViewModel())
        }
        
    }
}
