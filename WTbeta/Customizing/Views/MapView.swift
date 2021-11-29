//
//  MapView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI

struct MapView: View {
    
    @ObservedObject private var mapVM = MapVM()
    
    var body: some View {
        ScrollView {
            ForEach(mapVM.dogParks) { dogPark in
                DogParkCard(dogPark: dogPark, dogCount: 0)
            }
        }
        .onAppear {
            self.mapVM.fetchData()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
