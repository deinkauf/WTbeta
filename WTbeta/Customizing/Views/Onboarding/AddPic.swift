//
//  AddPic.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/29/21.
//

import SwiftUI

struct AddPic: View {
    
    @EnvironmentObject var userVM: UserVM
    
    @State var showCameraSheet = false
    @State var showLibrarySheet = false
    
    var name: String = ""
    var breed: String = ""
    var age: String = ""
    var bio: String = ""
    
    @State var profilePic = UIImage()
    
    var backgroundColor: LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1))]),
        startPoint: .leading,
        endPoint: .trailing)
    
    
    var body: some View {
        ZStack {
            
            backgroundColor
                .ignoresSafeArea(edges: .all)
            
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    //TITLE
                    Text("Dog Profile Picture")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                    //SUBTITLE
                    Text("Show off your best friend!")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                    HStack(spacing: 16){
                        Spacer()
                        //Camera Pic Upload Indicator
                        RoundedRectangle(cornerRadius: 16.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .frame(width: 75, height: 36)
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.white)
                            )
                            .onTapGesture {
                                showCameraSheet = true
                            }
                        //Library Pic Upload Indicator
                        RoundedRectangle(cornerRadius: 16.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .frame(width: 75, height: 36)
                            .overlay(
                                Image("photo.fill.on.rectangle.fill")
                                    .foregroundColor(.white)
                            )
                            .onTapGesture {
                                showLibrarySheet = true
                            }
                        Spacer()
                    }
                    //Select Profile Pic from Library
                    .sheet(isPresented: $showLibrarySheet) {
                        ImagePicker(sourceType: .photoLibrary,
                                    selectedImage: $profilePic)
                    }
                    //Take Profile Pic with Camera
                    .sheet(isPresented: $showCameraSheet){
                        ImagePicker(sourceType: .camera, selectedImage: $profilePic)
                    }
                    
                    var compressedPic = compressImage(image: profilePic)
                    
                    //Complete Sign Up Button
                    Button {
                        userVM.createDog(name: name, breed: breed, bio: bio, age: age, profilePic: compressedPic)
                        //Set ViewModel to loggedIn - changes view
                        self.userVM.checkLogin()
                    } label: {
                        GlowRectangle(text: "Complete Sign Up")
                    }
                }
                .padding(20)
            }
            .onBoardingFrame()
        }
        .navigationBarHidden(true)
    }
    
    func compressImage(image: UIImage) -> UIImage {
            let resizedImage = image.aspectFittedToHeight(200)
            resizedImage.jpegData(compressionQuality: 0.2) // Add this line

            return resizedImage
    }
}


//struct AddPic_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPic()
//    }
//}
