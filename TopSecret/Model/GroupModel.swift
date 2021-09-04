//
//  GroupModel.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import Foundation
import SwiftUI


struct Group: Identifiable{
    
    
    var groupName: String?
    var publicID: String?
    var id : String?
    var dateCreated: Date?
    var memberLimit: Int?
    var users: [User.ID]?
    
    init(dictionary: [String:Any]){
        self.id = UUID().uuidString
        self.groupName = dictionary["groupName"] as? String ?? ""
        self.publicID = dictionary["publicID"] as? String ?? ""
        self.dateCreated = dictionary["dateCreated"] as? Date ?? Date()
        self.memberLimit = dictionary["memberLimit"] as? Int ?? 1
        self.users = dictionary["users"] as? [User.ID] ?? [" "]
    }
    
    init(){
        self.id = UUID().uuidString
    }
    
    
}
