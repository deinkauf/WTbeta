//
//  DogParkView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

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
//                        ForEach(dogParkVM.dogIDsCheckedIn, id: \.self) { dogID in
//                            let dog = convertIdToDog(dogID: dogID)
//                            if dog != nil {DogCard(dog: dog!)}
//                        }
                    }
                }
                
            } else{ProgressView()}
        }
        
    }
    
//    func convertIdToDog(dogID: String) -> Dog? {
//        let db = Firestore.firestore()
//        var dog: Dog?
//        db.collection("dogs").document(dogID).getDocument { document, error in
//            dog = try? document?.data(as: Dog.self)
//        }
//        let count = 0
//        print("dog converted in dogparkview : \(count+1)")
//        return dog
//    }
}

//struct DogParkView_Previews: PreviewProvider {
//    static var previews: some View {
//        DogParkView()
//    }
//}
