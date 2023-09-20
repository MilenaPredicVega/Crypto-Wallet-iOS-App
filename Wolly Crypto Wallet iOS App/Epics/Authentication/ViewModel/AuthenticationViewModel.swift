//
//  AuthenticationViewModel.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 19.9.23..
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    private let repository: AuthenticationRepository
    private let useCase: AuthenticationUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isFirstNameValid: Bool = false
    @Published var isLastNameValid: Bool = false
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    
    @Published var showAlert: Bool = false
    
    @Published var firstName: String = "" {
        didSet { validateFirstName() }
    }
    @Published var lastName: String = "" {
        didSet { validateLastName() }
    }
    @Published var email: String = "" {
        didSet { validateEmail() }
    }
    @Published var password: String = "" {
        didSet { validatePassword() }
    }
    
    init(repository: AuthenticationRepository) {
        self.repository = repository
        self.useCase = AuthenticationUseCase(repository: repository)
    }
    
    private func validateFirstName() {
        isFirstNameValid = !firstName.isEmpty && firstName.count <= 30
    }
    
    private func validateLastName() {
        isLastNameValid = !lastName.isEmpty && lastName.count <= 30
    }
    
    private func validateEmail() {
        isEmailValid = isValidEmail(email) && email.count >= 5 && email.count <= 50
    }
    
    private func validatePassword() {
        isPasswordValid = password.count >= 4 && password.count <= 128
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func performRegistrationAndLogin() {
        guard isFirstNameValid, isLastNameValid, isEmailValid, isPasswordValid else {
            showAlert = true
            return
        }
        
        useCase.registerAndLogin(email: email, firstName: firstName, lastName: lastName, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { receivedCompletion in
                switch receivedCompletion {
                case .finished:
                  break
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    func performLogin() {
        guard isEmailValid, isPasswordValid else {
            showAlert = true
            return
        }
        
        repository.login(email: email, password: email)
            .sink(receiveCompletion: { receivedCompletion in
                switch receivedCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                }
            }, receiveValue: { loginResponse in
                print(loginResponse)
            })
            .store(in: &cancellables)
    }
}
