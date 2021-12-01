//
//  HomeView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct HomeView: View {
    
    @EnvironmentObject var userVM: UserVM
    
    @State var stillNoDefaultDogPark = false
    
    var body: some View {
        if userVM.checkedIn {
            DogParkView(dogParkVM: DogParkVM(dogParkID: userVM.dogParkCheckedInto))
        }
        else if userVM.hasDefaultDogPark {
            DogParkView(dogParkVM: DogParkVM(dogParkID: self.userVM.user.defaultDogParkID!))
        } else if !stillNoDefaultDogPark {
            ProgressView()
                .onAppear {
                    userVM.checkDefaultDogPark()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        stillNoDefaultDogPark = true
                    }
                }
        } else {
            VStack(alignment: .center) {
                Text("Click the 'star' icon on your preferred dogpark to view it's info here by default!")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
        }
    }
    
    
}

//struct DefaultDogParkView_Previews: PreviewProvider {
//    static var previews: some View {
//        DefaultDogParkView()
//    }
//}
