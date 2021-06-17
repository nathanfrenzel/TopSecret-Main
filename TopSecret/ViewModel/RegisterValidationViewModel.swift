//
//  RegisterValidationViewModel.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/13/21.
//




import Combine
import SwiftUI
import Firebase



class RegisterValidationViewModel : ObservableObject {
    
    
    
    
    @Published var username = ""
    @Published var password = ""
    @Published var rePassword = ""
    @Published var email = ""
    
    @Published var inLineErrorForPassword = ""
    
    
    @Published var isValid = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private static let predicatePassword = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z]).{6,}$")
    private static let predicateEmail = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}")



    
    //This method checks Firestore if the username being passed in is already registered
    func checkIfUsernameAvailable(username: String, completion: @escaping (Bool) -> Void){
        
        let collectionRef = Firestore.firestore().collection("users")
        collectionRef.whereField("username", isEqualTo: username).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting document: \(err.localizedDescription)")
            }else if(snapshot?.isEmpty)!{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    //This method checks Firestore if the email being passed in is already registered
    func checkIfEmailAvailable(email: String, completion: @escaping (Bool) -> Void){
        
        let collectionRef = Firestore.firestore().collection("users")
        collectionRef.whereField("email", isEqualTo: email).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting document: \(err.localizedDescription)")
            }else if(snapshot?.isEmpty)!{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    

    
    
    
   
    
    private var isEmailValidPublisher : AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {Self.predicateEmail.evaluate(with: $0)}
            .eraseToAnyPublisher()
    }
    
   
    
    
    
    private var arePasswordEqualPublisher : AnyPublisher<Bool, Never> {
        
        Publishers.CombineLatest($password, $rePassword)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { $0 == $1 }
            .eraseToAnyPublisher()
    }
    
    
    private var isPasswordStrongPublisher : AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { Self.predicatePassword.evaluate(with: $0) }
            .eraseToAnyPublisher()
    }
    
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordStatusModel, Never>{
        Publishers.CombineLatest3(isPasswordStrongPublisher,arePasswordEqualPublisher, isEmailValidPublisher)
            .map{
                if !$0 {return PasswordStatusModel.notStrongEnough}
                if !$1 {return PasswordStatusModel.repeatedPasswordWrong}
                if !$2 {return PasswordStatusModel.emailBadlyFormatted}
      
                
                return PasswordStatusModel.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher : AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isPasswordValidPublisher,isEmailValidPublisher)
            .map{ $0 == .valid && $1}
            .eraseToAnyPublisher()
    }
    
    func checkPassword(){
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map{ passwordStatusModel in
                
                switch passwordStatusModel {
                
                case .notStrongEnough:
                    return "Your password must be atleast 6 characters in length"
                case .repeatedPasswordWrong:
                    return "Password's do not match"
               
                case .emailBadlyFormatted:
                    return "Email is badly formatted"
                case .valid:
                    return "Valid Email and Password"
                    
                }
            }
            .assign(to: \.inLineErrorForPassword, on: self)
            .store(in: &cancellables)
    }
    
    
    
    
   
    init(){
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
        
       
    }
    
}


