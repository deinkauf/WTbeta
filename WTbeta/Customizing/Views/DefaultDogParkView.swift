//
//  DefaultDogParkView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct DefaultDogParkView: View {
    
    @EnvironmentObject var userVM: UserVM
    @ObservedObject var dogParkVM = DogParkVM()
    
    var body: some View {
        if userVM.user.defaultDogParkID != nil {
            DogParkView(dogParkVM: dogParkVM).onAppear {
                dogParkVM.fetchDogParkData(dogParkID: userVM.user.defaultDogParkID!)
            }
        } else { Text("No Default Dog Park")}
    }
}

struct DefaultDogParkView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultDogParkView()
    }
}
