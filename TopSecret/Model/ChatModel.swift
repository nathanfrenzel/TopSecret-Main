//
//  ChatModel.swift
//  TopSecret
//
//  Created by Bruce Blake on 9/8/21.
//

import Foundation
import SwiftUI

struct ChatModel : Identifiable {
    var id: String = UUID().uuidString
    var name: String?
    var memberAmount: Int?
    var users : [User.ID]?
    var dateCreated: Date?
    
    
    init(dictionary:[String:Any]){
        self.name = dictionary["name"] as? String ?? " "
        self.memberAmount = dictionary["memberAmount"] as? Int ?? 0
        self.users = dictionary["users"] as? [User.ID] ?? [" "]
        self.dateCreated = dictionary["dateCreated"] as? Date ?? Date()
    }
    init(){
        
    }
}
