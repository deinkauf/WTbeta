//
//  AddPic.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/29/21.
//
import SwiftUI

struct AddPic: View {
    
    @EnvironmentObject var userVM: UserVM
    
    var storageManager = StorageManager()
    
    var name: String = ""
    var breed: String = ""
    var age: String = ""
    var bio: String = ""
    var placeholder: String = "pawprint.circle"
    
    @State var profilePic = UIImage()
    @State var showCameraSheet = false
    @State var showLibrarySheet = false
    
    var backgroundColor: LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1))]),
        startPoint: .leading,
        endPoint: .trailing)
    
    
    var body: some View {
        ZStack {
            
            backgroundColor
                .ignoresSafeArea(edges: .all)
            
            VStack {
                VStack(spacing: 16) {
                    
                    VStack(alignment: .leading) {
                        //TITLE
                        Text("Dog Profile Picture")
                            .font(Font.largeTitle.bold())
                            .foregroundColor(.white)
                        
                        //SUBTITLE
                        Text("Show off your best friend!")
                            .font(.subheadline)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    VStack(alignment: .center) {
                        //Conditional to check for photo content, displays placeholder symbol if no picture added yet
                        if profilePic == UIImage() {
                            Image(placeholder)
                                .resizable()
                                .cornerRadius(50)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                        } else {
                            Image(uiImage: self.profilePic)
                                .resizable()
                                .cornerRadius(50)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                        }
                    }
                    
                    HStack(spacing: 16){
                        Spacer()

                        //Camera Pic Upload Indicator
                        RoundedRectangle(cornerRadius: 16.0)
                            .foregroundColor(.white)
                            .frame(width: 75, height: 36)
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)))
                            )
                            .onTapGesture {
                                showCameraSheet = true
                            }
                        
                        //Library Pic Upload Indicator
                        RoundedRectangle(cornerRadius: 16.0)
                            .foregroundColor(.white)
                            .frame(width: 75, height: 36)
                            .overlay(
                                Image("photo.fill.on.rectangle.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)))
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
                    
                    Button {
                        userVM.createDog(name: name, breed: breed, bio: bio, age: age, profilePic: profilePic)
                        //Set ViewModel to loggedIn - changes view
                        self.userVM.checkLogin()
                    } label: {
                        GlowRectangle(text: "Complete Sign Up")
                    }
                    
                }
                .padding(20)
                .padding(.top)
            }
            .onBoardingFrame()
        }
        .navigationBarHidden(true)
    }
}
