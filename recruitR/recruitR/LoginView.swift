//
//  LoginView.swift
//  recruitR
//
//  Created by Andy Huang on 4/28/22.
//

import SwiftUI

struct LoginView: View {
    @State var loggedIn: Bool = false
    var body: some View {
        if loggedIn {
            ContentView()
        } else {
            LoginScreen(loggedIn: $loggedIn)
        }
    }
}

struct LoginScreen: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var showingSignUp: Bool = false
    @Binding var loggedIn: Bool
    var body: some View {
        VStack() {
            // Logo and login fields
            Group {
            Image("niceLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(.bottom, 100)
            
            Text("Username")
                .padding(.trailing, 200)
            TextField("Enter username...", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 50)
            
            Text("Password")
                .padding(.top)
                .padding(.trailing, 200)
            SecureField("Enter password...", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 50)
            }
            
            // Sign In Button
            HStack {
                Spacer()
                Button("Sign In") {
                    // TODO: Implement login authenthication
                    loggedIn = true
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 15)
                .background(Color(red: 1, green: 117/255, blue: 117/255))
                .foregroundColor(Color.white)
                .clipShape(Capsule())
                
                Spacer()
            }
            .padding()
            
            // Sign Up Buttom
            HStack {
                Spacer()
                Text("Don't have an account?")
                Button("Sign up") {
                    
                }
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        // tap on anything in VStack to end text editing
        .onTapGesture {
              self.endTextEditing()
        }
    }
}

// For dismissing keyboard/textfield typing by tapping on any view
extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
