//
//  IntroTabView.swift
//  WTbeta
//
//  Created by Mason Hendry on 8/7/21.
//
// TODO -- PERFORM FUNCTIONALITY CHECK ON FULL RUN TO CHECK FOR NAVBAR HIDDEN IN / NAV VIEW
// TODO -- CHANGE BUTTON TO MATCH ONBOARDING GLOW BUTTONS
import SwiftUI

struct IntroTabView: View {
    
    var tabColor: LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1))]),
        startPoint: .leading,
        endPoint: .trailing)
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView{
                    //Welcome to Waggin Tails Tab
                    OnboardingTab(tabIcon: "pawprint.circle", title: "Welcome To Waggin Tails!", subTitle: "Bringing Happiness to the Dog Park one Waggin Tail at a Time")
                    
                    //Dog Park Population Count Feature Tab
                    OnboardingTab(tabIcon: "pawprint.circle", title: "Live Dog Park Numbers", subTitle: "Making planning easier for you whether you own a lone wolf or Popular Puppy")
                    
                    //Map Feature Tab
                    OnboardingTab(tabIcon: "pawprint.circle", title: "Dog Park Discovery", subTitle: "Find Your Dog's Favorite Park With Ease")
                    
                    //Dog ID Card Feature Tab
                    OnboardingTab(tabIcon: "pawprint.circle", title: "The Digital Doggy", subTitle: "Show Off Your Dog's Profile to the Community")
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
                // SIGN UP BUTTON -> toggles @state var signUp to display SignUpView()
                NavigationLink(
                    destination: LoginView(),
                    label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Spacer()
                            GlowRectangle(text: "Get Started")
                                .frame(width: 200, height: 50)
                        }
                        .padding(.bottom, 50)
                    })
            }
            .navigationBarHidden(true)
        }
    }
}

struct IntroTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            IntroTabView()
                .navigationBarHidden(true)
        }
        
    }
}

struct OnboardingTab: View {
    
    @State var tabIcon: String = ""
    @State var title: String = ""
    @State var subTitle: String = ""
    
    var tabColor: LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1))]),
        startPoint: .leading,
        endPoint: .trailing)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(tabColor)
            .blur(radius: 0.5)
            .overlay(
                VStack {
                    //IMAGE ICON
                    Image(tabIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    //FEATURE TITLE
                    Text(title)
                        .font(.title2)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                    //FEATURE SUBTITLE
                    Text(subTitle)
                        .font(.subheadline)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                    
                }
            )
            .shadow(color: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)).opacity(0.8), radius: 10)
            .padding()
    }
}
