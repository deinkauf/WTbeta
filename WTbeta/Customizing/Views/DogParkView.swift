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
        
        let _ = dogParkVM.fetchData()
        VStack {
            if dogParkVM.dogPark != nil {
                VStack {
                    DogParkCard(dogPark: dogParkVM.dogPark!)
//                    Text(dogParkVM.dogPark!.name!)
                    ScrollView {
                        ForEach(dogParkVM.dogIDsCheckedIn, id: \.self) { dogID in
                            Text("dogId : \(dogID)")
                        }
                    }
                }
                
            } else{ProgressView()}
        }
        
    }
}

//struct DogParkView_Previews: PreviewProvider {
//    static var previews: some View {
//        DogParkView()
//    }
//}
