//
//  AuthenticationView.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 15.9.23..
//

import SwiftUI

enum AuthenticationType {
    case login
    case registration
}

import SwiftUI

struct AuthenticationView: View {
    @State private var authenticationType: AuthenticationType = .login
    @ObservedObject var viewModel: AuthenticationViewModel
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            HeaderView(authenticationType: $authenticationType)
            FormView(authenticationType: $authenticationType, viewModel: viewModel)
        }
        .padding(.top, 60)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .linearGradientBackground(from: Color.primaryBlue, to: Color.primaryGreen)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(viewModel: AuthenticationViewModel(repository: AuthenticationRepositoryImpl(networkService: NetworkingService())))
    }
}

struct HeaderView: View {
    @Binding var authenticationType: AuthenticationType
    var body: some View{
        Text(authenticationType == .login ? AuthenticationScreensStrings.welcomeText : AuthenticationScreensStrings.createAccount)
            .applyTextStyle(.title)
        Image(authenticationType == .login ? "loginImage" : "createAccountImage")
    }
}

struct FormView: View {
    @Binding var authenticationType: AuthenticationType
    @ObservedObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack (spacing: 20){
            if authenticationType == .registration {
                CustomTextField(placeholder: AuthenticationScreensStrings.firstNamePlaceholder, text: $viewModel.firstName)
                CustomTextField(placeholder: AuthenticationScreensStrings.lastNamePlaceholder, text: $viewModel.lastName)
            }
            
            CustomTextField(placeholder: AuthenticationScreensStrings.emailPlaceholder, text: $viewModel.email)
            
            SecureField(AuthenticationScreensStrings.passwordPlaceholder, text: $viewModel.password)
            Divider()
            
            Spacer()
            
            CustomButton(title: authenticationType == .login ? AuthenticationScreensStrings.login : AuthenticationScreensStrings.createAccount,
                         action: authenticationType == .login ? {viewModel.performLogin()} : {viewModel.performRegistrationAndLogin()})
                .cornerRadius(10)
            
            HStack{
                Text(authenticationType == .login ? AuthenticationScreensStrings.dontHaveAnAccount : AuthenticationScreensStrings.alreadyHaveAnAccount)
                Text(authenticationType == .login ? AuthenticationScreensStrings.signUp : AuthenticationScreensStrings.login)
                    .foregroundColor(Color.primaryGreen)
                    .onTapGesture {
                        if authenticationType == .login {
                            authenticationType = .registration
                        } else {
                            authenticationType = .login
                        }
                    }
            }
            .padding(.bottom, 40)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(AuthenticationScreensStrings.errorTitle),
                message: Text(AuthenticationScreensStrings.validationMessage),
                dismissButton: .default(Text(AuthenticationScreensStrings.ok)) {
                    viewModel.showAlert = false
                }
            )
        }
    }
}
