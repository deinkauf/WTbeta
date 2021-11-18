//
//  LoginView.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/17/21.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct LoginView: View {
    
    @EnvironmentObject var model: UserModel
    
    @State var newUser = true
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var firstName: String = ""
    @State private var errorMessage: String? = nil
    
    var backgroundColor: LinearGradient = LinearGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1))]),
            startPoint: .leading,
            endPoint: .trailing)
    
    var body: some View {
        
        ZStack {
            
            backgroundColor
                .ignoresSafeArea(edges: .all)
            
            VStack {
                VStack(alignment: .leading, spacing: 16){
                    
                    Text(newUser ? "Create Account" : "Login")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                    Text("Join Dogs everywhere in a Digital Dogpark Community")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    //Email Text Field
                    CustomTextField(symbolName: "envelope.fill", textFieldtext: "Email", userFieldEntry: self.$email)
                         .keyboardType(.emailAddress)
                         .autocapitalization(.none)
                         .disableAutocorrection(true)
                    
                    //Username Text Field
                    if newUser {
                        
                        CustomTextField(symbolName: "text.bubble", textFieldtext: "First Name", userFieldEntry: self.$firstName)
                             .disableAutocorrection(true)
                        
                        CustomTextField(symbolName: "questionmark.circle", textFieldtext: "Username", userFieldEntry: self.$userName)
                             .autocapitalization(.none)
                             .disableAutocorrection(true)
                    }
                    
                    //Password Text Field
                    CustomTextField(symbolName: "key.fill", textFieldtext: "Password", userFieldEntry: self.$password, showingSecureField: true)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    //Error Messages
                    if errorMessage != nil {
                        Text(errorMessage!)
                    }
                    
                    
                    //Authentication Button
                    if newUser {
                        Button {
                            createAccount()
                        } label: {
                            GlowRectangle(text: "Create Account")
                        }
                    } else {
                        Button {
                            Login()
                        } label: {
                            GlowRectangle(text: "Login")
                        }
                    }
                    
                    //SIGN UP DISCLAIMER
                    if newUser {
                        Text("By Clicking on Sign up, you agree to our Terms of Service and Privacy policy")
                            .font(.footnote)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    //DIVIDER
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.1))
                    
                    //NewUser Toggle
                    HStack(spacing: 4) {
                        Text(newUser ?  "Already have an account?" : "Don't have an account?")
                            .font(.footnote)
                            .foregroundColor(Color.white.opacity(0.7))
                        Button {
                            newUser.toggle()
                            
                        } label: {
                            Text(newUser ? "Login" : "Create an Account")
                                .foregroundColor(.white)
                                .font(Font.footnote.bold())
                        }
                    }
                    
                }
                .padding(20)
            }
            .onBoardingFrame()
        }
        .navigationBarHidden(true)
    }
    
    func Login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            // triggers changes in view code so put on main thread
            DispatchQueue.main.async {
                guard error == nil else {
                    errorMessage = error!.localizedDescription
                    return
                }
                //clear error message
                self.errorMessage = nil
            }
            
            //set ViewModel to loggedIn - changes view
            model.checkLogin()
        }
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result,
            error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    errorMessage = error!.localizedDescription
                    return
                }
                //clear error message
                self.errorMessage = nil
                
                //create new user doc
                createUserDoc()
            }
            
            //set ViewModel to loggedIn - changes view
            model.checkLogin()
            
            // Navigate user to AddDogDetails View
        }
    }
    
    func createUserDoc() {
        if let currentUser = Auth.auth().currentUser {
            let trimmedName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let db = Firestore.firestore()
            let userDoc = db.collection("users").document(currentUser.uid)
            userDoc.setData(["name" : trimmedName, "userName": userName, "usersDogs" : []])
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
