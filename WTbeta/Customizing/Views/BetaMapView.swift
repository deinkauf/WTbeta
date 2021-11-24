//
//  BetaMapView.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/23/21.
//

import SwiftUI

struct BetaMapView: View {
    
    @ObservedObject var model = MapVM()
    
    var body: some View {
        
        VStack {
            List(model.DogParks) { dp in
                
                VStack {
                    Text(dp.name ?? "")
                        .font(.title)
                    Text(dp.id ?? "")
                }
                .foregroundColor(.white)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                )
            }
            Button("Add DogPark"){
                model.AddDogPark()
            }
        }
        
    }
}

struct BetaMapView_Previews: PreviewProvider {
    static var previews: some View {
        BetaMapView()
    }
}
