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
    
    var body: some View {
        
        if userVM.hasDefaultDogPark == false {
            Text("does not have default dog park")
                .onAppear {
                    userVM.checkDefaultDogPark()
                }
            
        } else {
            DogParkView(dogParkVM: DogParkVM(dogParkID: self.userVM.user.defaultDogParkID!))
        }
    }
    
    
}

//struct DefaultDogParkView_Previews: PreviewProvider {
//    static var previews: some View {
//        DefaultDogParkView()
//    }
//}
