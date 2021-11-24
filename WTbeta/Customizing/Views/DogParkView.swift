//
//  DogParkView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI
import Firebase

struct DogParkView: View {
    
    @EnvironmentObject var userVM: UserVM
    @ObservedObject var dogParkVM: DogParkVM
    
    var body: some View {
        if dogParkVM.dogPark != nil {
            VStack {
                DogParkCard(dogPark: dogParkVM.dogPark!)
                ScrollView {
                    ForEach(dogParkVM.dogsCheckedIn) { dog in
                        DogCard(dog: dog)
                    }
                }
            }
            
        } else{ProgressView()}
    }
}

//struct DogParkView_Previews: PreviewProvider {
//    static var previews: some View {
//        DogParkView()
//    }
//}
