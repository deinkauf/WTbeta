//
//  MapView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var mapVM = MapVM()
    
    init() {
        fetchData()
    }

    var body: some View {
        
        NavigationView {
            Map(coordinateRegion: $mapVM.region , showsUserLocation: true, annotationItems: mapVM.dogParks) {
                item in
                
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.location?.latitude ?? printError(),
                                                                 longitude: item.location?.longitude ?? printError())) {
                    
                    let dogParkVM = DogParkVM(dogParkID: item.id!)
                    NavigationLink {
                        
                        DogParkView(dogParkVM: dogParkVM)
                    } label: {
                        
                        Image(systemName: "house.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }

                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    fetchData()
                }
            }
            .ignoresSafeArea()
            .accentColor(Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)))
            
            
        }
        
        
        
    }
    
    func printError() -> Double {
        print("-----ERROR----- error in mapView printing location coordinate nil" )
        return 0
    }
    
    func fetchData() {
    
        mapVM.checkIfLocationServicesIsEnabled()
        mapVM.addDogParksToDB()
        mapVM.fetchDogParks()

    }
    
//    @ObservedObject private var mapVM = MapVM()
//    
//    var body: some View {
//        
//        let _ = self.mapVM.fetchData()
//        NavigationView {
//            ScrollView {
//                ForEach(mapVM.dogParks) { dogPark in
//                    NavigationLink {
//                        if dogPark.id != nil {
//                            let dogParkVM = DogParkVM(dogParkID: dogPark.id!)
//                            let _ = dogParkVM.fetchData()
//                            DogParkView(dogParkVM: dogParkVM)
//                                .onAppear {
//                                    print(dogPark.id)
//                                }
//                            
//                        }
//                    } label: {
//                        DogParkCard(dogPark: dogPark, dogCount: 0)
//                    }
//                }
//            }.navigationBarHidden(true)
//        }
//    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
