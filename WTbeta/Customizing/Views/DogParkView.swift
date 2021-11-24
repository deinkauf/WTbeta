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
            DogParkCard(dogPark: dogParkVM.dogPark!)
        } else{Text("loading dog park...")}
    }
}

//struct DogParkView_Previews: PreviewProvider {
//    static var previews: some View {
//        DogParkView()
//    }
//}
