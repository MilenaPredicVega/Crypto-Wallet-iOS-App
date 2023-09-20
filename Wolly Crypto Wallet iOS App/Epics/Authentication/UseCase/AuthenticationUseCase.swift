//
//  AuthenticationUseCase.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 20.9.23..
//

import Foundation
import Combine

class AuthenticationUseCase {
    private let repository: AuthenticationRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: AuthenticationRepository) {
        self.repository = repository
    }
    
    func registerAndLogin(email: String, firstName: String, lastName: String, password: String) -> AnyPublisher<(Void, Void), APIError> {
        let registrationPublisher = repository.registration(email: email, firstName: firstName, lastName: lastName, password: password)
            .mapError { error -> APIError in
                return APIError.statusMessage(message: error.localizedDescription)
            }
        
        let loginPublisher = registrationPublisher
            .flatMap { registrationResponse -> AnyPublisher<Void, APIError> in
                return self.repository.login(email: email, password: password)
            }
        
        return Publishers.CombineLatest(registrationPublisher, loginPublisher)
            .eraseToAnyPublisher()
    }
}
