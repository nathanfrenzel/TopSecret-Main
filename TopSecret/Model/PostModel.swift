//
//  PostModel.swift
//  TopSecret
//
//  Created by nathan frenzel on 6/12/21.
//

import Foundation
import Firebase


struct PostModel {
    let id: String
    let username: String
    let email: String
    let fullName: String
    let groupName: String
    let groupPictureUrl: String
    let caption: String
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullname"] as? String ?? ""
        self.groupName = dictionary["groupname"] as? String ?? ""
        self.groupPictureUrl = dictionary["grouppicture"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
