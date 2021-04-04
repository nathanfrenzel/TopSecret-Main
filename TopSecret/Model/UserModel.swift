//
//  UserModel.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/3/21.
//

import Foundation

struct User : Identifiable{
    var id : String
    var username: String
    var email: String
    var password: String
    var firstname: String
    var lastname: String
    


init(dictionary: [String:Any]) {
    self.id = dictionary["uid"] as? String ?? ""
    self.username = dictionary["username"] as? String ?? ""
    self.email = dictionary["email"] as? String ?? ""
    self.password = dictionary["password"] as? String ?? ""
    self.firstname = dictionary["firstname"] as? String ?? ""
    self.lastname = dictionary["lastname"] as? String ?? ""
}

}
