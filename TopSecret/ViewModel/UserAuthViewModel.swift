//
//  UserAuthViewModel.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/3/21.
//

import Foundation
import Firebase


class UserAuthViewModel : ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: User?
    
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }

    
    func registerUser(email: String, password: String, username: String, fullname : String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if let err = err{
                print("DEBUG: ERROR: \(err.localizedDescription)")
                return
            }
            
            guard let user = result?.user else {return}
            
            let data = ["email": email,
                        "username": username,
                        "fullname": fullname,
                        "uid": user.uid]
            COLLECTION_USER.document(user.uid).setData(data){ _ in
                self.userSession = user
                self.fetchUser()
                print("DEBUG: Succesfully uploaded user data!")
            }
        }
    }
    func signIn(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email , password: password) { (result, err) in
            if let err = err{
                print("DEBUG: Failed to login: \(err.localizedDescription)")
                return
            }
            
            print("DEBUG: Succesfully logged in!")
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    func signOut(){
        userSession = nil
        try? Auth.auth().signOut()
    }
    func fetchUser(){
        guard let uid = userSession?.uid else {return}
        
        COLLECTION_USER.document(uid).getDocument { (snapshot, _) in
            guard let data = snapshot?.data() else {return}
            let user = User(dictionary: data)
            self.user = user
        }
    }
}
