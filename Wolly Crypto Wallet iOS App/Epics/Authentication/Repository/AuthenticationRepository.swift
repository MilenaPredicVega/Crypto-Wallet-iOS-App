//
//  AuthenticationRepository.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 19.9.23..
//

import UIKit
import Combine

protocol AuthenticationRepository {
    func login(email: String, password: String) -> AnyPublisher<Void, APIError>
    func registration(email: String, firstName: String, lastName: String, password: String) -> AnyPublisher<Void, APIError>
}

class AuthenticationRepositoryImpl: AuthenticationRepository {
    
    @Published var tokenExists = CurrentValueSubject<Bool, Never>(false)
    let networkService: NetworkingService
    
    init(networkService: NetworkingService){
        self.networkService = networkService
        checkTokenExistence()
    }
    
    func login(email: String, password: String) -> AnyPublisher<Void, APIError> {
        networkService.publisherForRequest(
            router: AuthenticationRouter.logIn,
            request: LoginAPIRequest(email: email, password: password),
            responseType: LoginAPIResponse.self,
            encoder: NetworkParameterEncoder.json
        )
        //TODO: save data from response to database
        .flatMap{ [weak self] loginAPIResponse -> AnyPublisher<Void, APIError> in
            guard let self = self else {
                return Fail(error: APIError.unknownError)
                    .eraseToAnyPublisher()
            }
            
            guard let token = loginAPIResponse.jwtToken else {
                return Fail(error: APIError.unknownError)
                    .eraseToAnyPublisher()
            }
          //MARK: temporary solution
            UserDefaults.standard.set(token, forKey: "AuthTokenKey")
            self.tokenExists.send(true)
            
            return Just(())
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }
        .mapError { error -> APIError in
            return APIError.statusMessage(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
    
    func registration(email: String, firstName: String, lastName: String, password: String) -> AnyPublisher<Void, APIError> {
        networkService.publisherForRequest(
            router: AuthenticationRouter.registration,
            request: CreateAccountAPIRequest(email: email, firstName: firstName, lastName: lastName, password: password),
            responseType: RegistrationAPIResponse.self,
            encoder: NetworkParameterEncoder.json
        )
        //TODO: save data from response to database
        .map { _ in
            return ()
        }
        .mapError { error -> APIError in
            return APIError.statusMessage(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
    
    private func checkTokenExistence() {
        if UserDefaults.standard.object(forKey: "AuthTokenKey") != nil {
            tokenExists.send(true)
        } else {
            tokenExists.send(false)
        }
    }
}
