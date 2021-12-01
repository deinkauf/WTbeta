//
//  CreateDogView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/20/21.
//

import SwiftUI

struct CreateDogView: View {
    
    @EnvironmentObject var userVM: UserVM
    
    var storageManager = StorageManager()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var created: Bool = false
    
    @State var isLoading: Bool = false
    
    @State var dogID: String = ""
    @State var name: String = ""
    @State var breed: String = ""
    @State var age: String = ""
    @State var bio: String = ""
    
    var placeholder: String = "pawprint.circle"
    @State var profilePic = UIImage()
    @State var cameraDialog = false
    @State var showCameraSheet = false
    @State var showLibrarySheet = false
    
    var body: some View {
        
        ZStack {
            
            //replace color with background image
            //                backgroundColor
            //                    .ignoresSafeArea(edges: .all)
            VStack {
                VStack(spacing: 16) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            //TITLE
                            Text("Add New Dog")
                                .font(Font.largeTitle.bold())
                                .foregroundColor(.white)
                            
                            //SUBTITLE
                            Text("Tap the pawprint below to add a profile picture")
                                .font(.subheadline)
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        Spacer()
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white.opacity(0.7))
                                .aspectRatio(contentMode: .fill)
                                .padding(.horizontal)
                        }
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
                                .onTapGesture {
                                    self.cameraDialog = true
                                }
                                .actionSheet(isPresented: $cameraDialog) {
                                    ActionSheet(title: Text("Choose "),
                                                buttons: [
                                                    .default(Text("Camera")) {
                                                        showCameraSheet = true
                                                    },
                                                    .default(Text("Library")) {
                                                        showLibrarySheet = true
                                                    },
                                                    .cancel()
                                                ])
                                }
                        } else {
                            Image(uiImage: self.profilePic)
                                .resizable()
                                .cornerRadius(50)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .onTapGesture {
                                    self.cameraDialog = true
                                }
                                .actionSheet(isPresented: $cameraDialog) {
                                    ActionSheet(title: Text("Choose a New Photo"), message: Text("Pick a photo you like"),
                                                buttons: [
                                                    .default(Text("Camera")) {
                                                        showCameraSheet = true
                                                    },
                                                    .default(Text("Library")) {
                                                        showLibrarySheet = true
                                                    },
                                                    .cancel()
                                                ])
                                }
                        }
                        
                    }
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        //DOG NAME
                        CustomTextField(symbolName: "pawprint.fill", textFieldtext: "Your Dog's Name", userFieldEntry: $name)
                        //BREED
                        CustomTextField(symbolName: "rosette", textFieldtext: "Breed Type", userFieldEntry: $breed)
                        //AGE
                        CustomNumField(symbolName: "123.rectangle.fill", textFieldtext: "Age", userFieldEntry: $age)
                        //BIO
                        CustomTextField(symbolName: "plus.bubble", textFieldtext: "Make it fun!", userFieldEntry: $bio)
                        
                        //Select Profile Pic from Library
                        .sheet(isPresented: $showLibrarySheet) {
                            ImagePicker(sourceType: .photoLibrary,
                                        selectedImage: $profilePic)
                        }
                        
                        //Take Profile Pic with Camera
                        .sheet(isPresented: $showCameraSheet){
                            ImagePicker(sourceType: .camera, selectedImage: $profilePic)
                        }
                        
                        Spacer()
                        
                        //NEXT BUTTON
                        if name != "" && breed != "" && age != "" && bio != "" {
                            Button {
                                userVM.createDog(name: name, breed: breed, bio: bio, age: age, profilePic: profilePic)
                            } label: {
                                GlowRectangle(text: "Create")
                            }
                        } else {
                            GlowRectangle(text: "Create")
                                .opacity(0.5)
                        }
                        Spacer()
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

struct CreateDogView_Previews: PreviewProvider {
    static var previews: some View {
        CreateDogView()
    }
}
